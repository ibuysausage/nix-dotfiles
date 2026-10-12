#!/usr/bin/env bash
set -euo pipefail

PARENT="/etc/nixos"
PREFIX="chore(submodule): update"

cd "$PARENT"

# Don't accidentally commit while a merge or rebase is in progress.
if [[ -d "$(git rev-parse --git-path rebase-merge)" ||
      -d "$(git rev-parse --git-path rebase-apply)" ||
      -f "$(git rev-parse --git-path MERGE_HEAD)" ]]; then
    echo "Parent repository is rebasing or merging; skipping."
    exit 1
fi

while read -r _ path; do
    [[ -n "$path" ]] || continue
    sub="$PARENT/$path"

    [[ -e "$sub/.git" ]] || continue

    # Only update submodules with a branch and an upstream.
    branch="$(git -C "$sub" symbolic-ref --quiet --short HEAD || true)"
    [[ -n "$branch" ]] || continue

    upstream="$(git -C "$sub" rev-parse --abbrev-ref \
        --symbolic-full-name '@{upstream}' 2>/dev/null || true)"
    [[ -n "$upstream" ]] || {
        echo "Skipping $path: no upstream configured."
        continue
    }

    # Refresh remote-tracking refs after the push.
    git -C "$sub" fetch --quiet || {
        echo "Fetch failed for $path"
        continue
    }

    head="$(git -C "$sub" rev-parse HEAD)"
    remote="$(git -C "$sub" rev-parse "$upstream")"
    recorded="$(git -C "$PARENT" rev-parse ":$path" 2>/dev/null || true)"

    # Only record a cleanly pushed branch tip that differs from the parent.
    if [[ "$head" != "$remote" ]]; then
        echo "Skipping $path: HEAD is not the upstream tip."
        continue
    fi

    if [[ "$head" == "$recorded" ]]; then
        continue
    fi

    if [[ -n "$(git -C "$sub" status --porcelain)" ]]; then
        echo "Skipping $path: submodule has uncommitted changes."
        continue
    fi

    name="$(basename "$path")"
    msg="$PREFIX $name"
    last_msg="$(git -C "$PARENT" log -1 --format=%s)"

    git -C "$PARENT" add -- "$path"

    if [[ "$last_msg" == "$msg" ]]; then
        git -C "$PARENT" commit -m "fixup! $msg" -- "$path"
    else
        git -C "$PARENT" commit -m "$msg" -- "$path"
    fi

    echo "Recorded $path at $head"
done < <(git -C "$PARENT" config -f .gitmodules \
    --get-regexp '^submodule\..*\.path$' || true)

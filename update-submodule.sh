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

    if git -C "$PARENT" diff --cached --quiet; then
        echo "No parent changes to commit for $path"
        continue
    fi

    git -C "$PARENT" commit -m "$msg" -- "$path"

    # Combine consecutive commits with the same submodule-update message.
    while [[ "$(git -C "$PARENT" log -1 --format=%s)" == "$msg" ]] &&
          [[ "$(git -C "$PARENT" log -2 --format=%s | tail -n 1)" == "$msg" ]]; do
        echo "Squashing consecutive '$msg' commits..."

        # Preserve the combined changes and retain the common message.
        git -C "$PARENT" reset --soft HEAD~2
        git -C "$PARENT" commit -m "$msg"
    done

    echo "Recorded $path at $head"
done < <(git -C "$PARENT" config -f .gitmodules \
    --get-regexp '^submodule\..*\.path$' || true)

echo "Pushing parent repository..."

if git -C "$PARENT" push; then
    echo "Push successful."
else
    echo "Push failed. Attempting to pull and rebase remote changes..."

    if git -C "$PARENT" pull --rebase; then
        echo "Pull/rebase successful. Retrying push..."

        if git -C "$PARENT" push; then
            echo "Push successful after rebase."
        else
            echo "ERROR: Push still failed after pulling remote changes." >&2
            echo "Please resolve manually in: $PARENT" >&2
            exit 1
        fi
    else
        echo "ERROR: Pull/rebase failed." >&2
        echo "Please resolve the issue manually in: $PARENT" >&2
        echo "Check the repository with: git -C \"$PARENT\" status" >&2
        exit 1
    fi
fi

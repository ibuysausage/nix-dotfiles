#!/usr/bin/env bash
set -euo pipefail

REPO="$(git rev-parse --show-toplevel)"
cd "$REPO"

MSG_PREFIX="chore(submodule): update"

# Make sure submodule metadata exists
git submodule update --init --recursive

while IFS= read -r submodule; do
    echo "Checking $submodule..."

    pushd "$submodule" >/dev/null

    # Ignore dirty submodules
    if [[ -n "$(git status --porcelain)" ]]; then
        echo "Skipping dirty submodule: $submodule"
        popd >/dev/null
        continue
    fi

    branch="$(git symbolic-ref --short HEAD 2>/dev/null || true)"

    if [[ -z "$branch" ]]; then
        echo "Skipping detached submodule: $submodule"
        popd >/dev/null
        continue
    fi

    git fetch origin "$branch" >/dev/null 2>&1 || {
        echo "Failed fetching $submodule"
        popd >/dev/null
        continue
    }

    local_rev="$(git rev-parse HEAD)"
    remote_rev="$(git rev-parse "origin/$branch")"

    if [[ "$local_rev" == "$remote_rev" ]]; then
        popd >/dev/null
        continue
    fi

    echo "$submodule has new commits"

    popd >/dev/null

    # Update gitlink in parent
    git add "$submodule"

    name="$(basename "$submodule")"
    msg="$MSG_PREFIX $name"

    last_msg="$(git log -1 --pretty=%s || true)"

    if [[ "$last_msg" == "$msg" ]]; then
        git commit \
            -m "fixup! $msg"
    else
        git commit \
            -m "$msg"
    fi

done < <(git config --file .gitmodules --get-regexp path | awk '{print $2}')

#!/usr/bin/env bash
set -euo pipefail

if (( $# != 2 )); then
    echo "Usage: $0 <v-tag> <message>" >&2
    exit 2
fi

tag="$1"
message="$2"

if [[ "$tag" != v* ]]; then
    echo "Release tags must start with 'v' (for example, v1.0.0)." >&2
    exit 2
fi

if git show-ref --verify --quiet "refs/tags/$tag"; then
    git tag -d "$tag"
fi

if git ls-remote --exit-code --tags origin "refs/tags/$tag" >/dev/null 2>&1; then
    git push origin --delete "$tag"
fi

git tag -a "$tag" -m "$message"
git push origin "$tag"

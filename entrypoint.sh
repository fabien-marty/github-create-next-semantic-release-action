#!/bin/sh

set -eu

cd /github/workspace || exit 1
git config --global --add safe.directory '*'

exec /app/bin/github-create-next-semantic-release .

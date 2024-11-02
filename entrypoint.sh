#!/bin/sh

set -u

cd /github/workspace || exit 1
git config --global --add safe.directory '*' || exit 1

NEW_TAG=$(/app/bin/github-create-next-semantic-release .)
RES=$?
if test ${RES} -ne 0; then
  if test ${RES} -eq 2; then
    echo "WARNING: no release created (because no new PR found)"
    echo "new-tag=" >> "${GITHUB_OUTPUT}"
    exit 0
  fi
  echo "ERROR: failed to create release"
  exit ${RES}
fi
echo "OK: release created"
echo "new-tag=${NEW_TAG}" >> "${GITHUB_OUTPUT}"

#!/bin/sh

set -eu

cd /github/workspace || exit 1
git config --global --add safe.directory '*'

TMP=$(/app/bin/github-next-semantic-version .)
echo "${TMP}" |grep '=>' 2>/dev/null || ( echo "FAILED"; exit 1 )

BEFORE=$(echo "${TMP}" |awk -F ' => ' '{print $1;}')
AFTER=$(echo "${TMP}" |awk -F ' => ' '{print $2;}')

echo "latest-version=${BEFORE}"
echo "next-version=${AFTER}"
if test "${GITHUB_OUTPUT:-}" != ""; then
  echo "latest-version=${BEFORE}" >> ${GITHUB_OUTPUT}
  echo "next-version=${AFTER}" >> ${GITHUB_OUTPUT}
fi

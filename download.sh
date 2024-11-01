#!/bin/sh

URL=$1
NAME=$2
if test "${URL}" = ""; then
    echo "ERROR: missing URL"
    exit 1
fi
if test "${NAME}" = ""; then
    echo "ERROR: missing NAME"
    exit 1
fi
echo "URL=${URL}"
echo "NAME=${NAME}"

ARCH=${3:-linux-amd64}
echo "ARCH=${ARCH}"

curl -s "${URL}" \
| grep "browser_download_url" \
| grep "${ARCH}" \
| grep "/${NAME}/" \
| grep -v "md5" 

LOCATION=$(curl -s "${URL}" \
| grep "browser_download_url" \
| grep "${ARCH}" \
| grep "/${NAME}-v" \
| grep -v "md5" \
| awk '{ print $2 }' \
| sed 's/,$//'       \
| sed 's/"//g' )

if test "${LOCATION}" = ""; then
    echo "ERROR: can't find the download location"
    exit 1
fi

echo "Downloading $LOCATION..."
curl -L -o "${NAME}" "${LOCATION}"

#!/bin/sh

JSON=$(curl -s https://api.github.com/repos/fabien-marty/github-next-semantic-version/releases/latest)

VERSION=$(echo "${JSON}" \
| grep '"name": "v' \
| awk -F ': ' '{print $2}' \
| sed 's/"//g' \
| sed 's/,//g')

URL=$(echo "${JSON}" \
| grep '"url": "' \
| grep -v 'assets' \
| grep 'releases' \
| awk -F ': ' '{print $2}' \
| sed 's/"//g' \
| sed 's/,//g')

echo "${VERSION} ${URL}"
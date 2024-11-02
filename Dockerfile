FROM alpine:latest

RUN apk add git curl
COPY download.sh /app/bin/

# Download version v0.5.5
RUN mkdir -p /app/bin && \
    cd /app/bin && \
    ./download.sh "https://api.github.com/repos/fabien-marty/github-next-semantic-version/releases/183218474" github-create-next-semantic-release && \
    chmod +x github-create-next-semantic-release

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
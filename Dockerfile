FROM alpine:latest

RUN apk add git curl
COPY download.sh /app/bin/

# Download version v0.7.2
RUN mkdir -p /app/bin && \
    cd /app/bin && \
    ./download.sh "https://api.github.com/repos/fabien-marty/github-next-semantic-version/releases/205232095" github-create-next-semantic-release && \
    chmod +x github-create-next-semantic-release

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
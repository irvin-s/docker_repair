FROM ubuntu:xenial

COPY . /diefarbe

WORKDIR /diefarbe

RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    npm install && \
    rm -rf /var/lib/apt/lists/*

HEALTHCHECK --timeout=5s CMD curl -f http://localhost:3030/info || exit 1

# If the container runs in the background (`-d`), using this array notation (as a CMD or ENTRYPOINT) is
# the only way that seems to allow the container to shutdown gracefully on a `docker stop` request. Otherwise
# it will be killed after the timeout.
ENTRYPOINT ["node", "/diefarbe/dist/index.js"]
FROM        golang:1.6-alpine

ENV         DIR /go/src/github.com/mna/juggler

# Install netcat to detect when redis becomes available
RUN         set -x \
                && apk add --no-cache --virtual git \
                && apk add --no-cache --virtual netcat-openbsd

# Copy the app in its correct path in the container.
RUN         mkdir -p $DIR
WORKDIR     $DIR
COPY        . $DIR

# Build the callee
RUN         go get github.com/garyburd/redigo/redis \
                && go get github.com/pborman/uuid \
                && go get github.com/mna/redisc \
                && go build ./cmd/juggler-callee/

ENTRYPOINT  ["./juggler-callee"]
CMD         ["--redis", "redis:6379"]


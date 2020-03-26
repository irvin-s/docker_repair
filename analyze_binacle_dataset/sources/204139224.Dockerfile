FROM        golang:1.6-alpine

ENV         DIR /go/src/github.com/mna/juggler

RUN         set -x \
                && apk add --no-cache --virtual git

# Copy the app in its correct path in the container.
RUN         mkdir -p $DIR
WORKDIR     $DIR
COPY        . $DIR

# Build the client
RUN         go get github.com/gorilla/websocket \
                && go get github.com/pborman/uuid \
                && go get golang.org/x/crypto/ssh/terminal \
                && go get golang.org/x/net/context \
                && go build ./cmd/juggler-client/
CMD         ["./juggler-client", "--addr", "ws://docker_server_1:9000/ws"]


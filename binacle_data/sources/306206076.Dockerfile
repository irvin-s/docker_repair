FROM golang:alpine

COPY . /go/src/github.com/segmentio/consul-router

ENV CGO_ENABLED=0
RUN apk add --no-cache git && \
    cd /go/src/github.com/segmentio/consul-router && \
    go get -v github.com/kardianos/govendor && \
    govendor sync && \
    go build -v -o /consul-router && \
    apk del git && \
    rm -rf /go/*

ENTRYPOINT ["/consul-router"]

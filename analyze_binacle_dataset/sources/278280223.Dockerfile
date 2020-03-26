FROM golang:1.9 as builder

ADD . /go/src/github.com/minutelab/mless

WORKDIR /go/src/github.com/minutelab/mless

RUN scripts/build

FROM alpine

RUN apk add --update curl && rm -rf /var/cache/apk/*

COPY --from=builder /go/bin/mless /usr/local/bin/

ADD mlessd/runtime/runtimes /usr/local/mless/runtime

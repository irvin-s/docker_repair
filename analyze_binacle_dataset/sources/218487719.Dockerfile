FROM golang:alpine

MAINTAINER Sergey Mudrik

RUN set -ex \
    && apk add --no-cache git bash gcc musl-dev linux-headers \
    && go get github.com/alecthomas/gometalinter \
    && gometalinter --install || true \
    && go get github.com/msoap/go-carpet

COPY go-checks.sh $GOPATH/bin/

ENV GOPATH=$GOPATH:/app

WORKDIR /app

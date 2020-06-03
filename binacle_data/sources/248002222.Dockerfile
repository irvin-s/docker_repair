FROM golang:alpine

MAINTAINER xzdbd <xzdbd@sina.com>

ENV LISTEN_PORT 4000

RUN apk update && \
    apk upgrade && \
    apk add git

RUN go get -ldflags "-X main.VERSION=$(date -u +%Y%m%d) -s -w" github.com/xtaci/kcptun/server

EXPOSE $LISTEN_PORT/udp

VOLUME /kcptun.json

CMD /go/bin/server -c /kcptun.json
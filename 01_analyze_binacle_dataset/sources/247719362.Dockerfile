FROM golang:alpine

MAINTAINER seanchann <seanchann@foxmail.com>

RUN set -ex \
	&& apk add --no-cache --virtual bash

COPY . /go/src/shadowsocks-go/
COPY /build/build-image/files/entrypoint.sh /entrypoint.sh
COPY /build/build-image/files/config.json //conf/config.json

RUN cd /go/src/shadowsocks-go/ \
	&& cp vendor/* /go/src/ -rf \
	&& cd cmd/shadowss/ \
	&& go build -v  -o  /go/bin/shadowss \
	&& chmod +x /entrypoint.sh


CMD ["entrypoint.sh"]

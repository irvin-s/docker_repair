FROM golang:alpine

MAINTAINER seanchann <seanchann@foxmail.com>

RUN set -ex \
	&& apk add --no-cache --virtual bash

COPY . /go/src/shadowsocks/shadowsocks-go/
COPY /build/build-image/files/entrypoint.sh /entrypoint.sh
COPY /build/build-image/files/mu-config.conf /conf/mu-config.conf
COPY /build/build-image/files/multi-user.json /conf/config.json

RUN cd /go/src/shadowsocks/shadowsocks-go/ \
	&& cp vendor/* /go/src/ -rf \
	&& cp sample-config/server-multi-port.json /config.json \
	&& cd cmd/shadowsocks-server/ \
	&& go build -v -o  /go/bin/shadowss \
	&& cd mu \
	&& go build -v -o  /go/bin/shadowss-mu \
	&& chmod +x /entrypoint.sh


CMD ["entrypoint.sh"]

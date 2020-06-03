FROM alpine:latest

MAINTAINER niuyuxian <ncc0706@gmail.com>

RUN apk add --no-cache py-pip && \
	pip install shadowsocks && \
	rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/ssserver"]
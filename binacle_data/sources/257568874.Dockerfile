FROM alpine:3.4
MAINTAINER janes https://github.com/hxer

## S6 Overlay 
ENV S6_VERSION=v1.18.1.1

RUN apk add --update wget \
	&& wget https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz --no-check-certificate --quiet -O /tmp/s6-overlay.tar.gz \
	&& tar xvfz /tmp/s6-overlay.tar.gz -C / \
	&& rm -f /tmp/s6-overlay.tar.gz \
	&& apk del wget \
	&& rm -rf /var/cache/apk/*

## RootFS
ADD root /

ENTRYPOINT ["/init"]

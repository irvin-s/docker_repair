# Run tor in an Alpine Linux container
#
# docker run -d \
#	--restart=always \
#	-p 9050:9050 \
#	--name tor \
#	danilo/tor

FROM danilo/alpine:latest
MAINTAINER Danilo Falcão <danilo@falcao.org>

RUN apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add tor && \
  rc-update add tor && \
  rm -rf /var/cache/apk/*

ADD torrc.default /etc/tor/torrc

EXPOSE 9050

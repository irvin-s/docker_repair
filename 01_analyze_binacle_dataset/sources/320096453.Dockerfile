# Run privoxy in an Alpine Linux container
#
# docker run -d \
#	--restart=always \
#	--link tor:tor \
#	-p 8118:8118 \
#	--name privoxy \
#	danilo/privoxy

FROM danilo/alpine:latest
MAINTAINER Danilo Falcão <danilo@falcao.org>

RUN apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add privoxy && \
  rc-update add privoxy && \
  rm -rf /var/cache/apk/*

ADD privoxy.config /etc/privoxy/config

EXPOSE 8118

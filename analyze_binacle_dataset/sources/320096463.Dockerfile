# Run znc in an Alpine Linux container
#
# docker run -d \
#	--restart=always \
#	-p 6697:6697 \
#	--name znc \
#	danilo/znc

FROM danilo/alpine:latest
MAINTAINER Danilo Falcão <danilo@falcao.org>

RUN apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add znc && \
  apk --no-cache add ca-certificates && \
  adduser -D irc -s /bin/ash -h /home/irc && \
  sed -i 's/ZNC_CONF=\"\/var\/lib\/znc\"/ZNC_CONF=\"\/home\/irc\/.znc\"/g' /etc/conf.d/znc && \
  sed -i 's/ZNC_USER=\"znc\"/ZNC_USER=\"irc\"/g' /etc/conf.d/znc && \
  rc-update add znc && \
  rm -rf /var/cache/apk/*

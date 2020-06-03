FROM alpine:latest
MAINTAINER OpenGG <liy099@gmail.com>

COPY root/ /

RUN set -xe \
    && apk add --no-cache aria2 \
    && chmod +x /init.sh

VOLUME /config /downloads

EXPOSE 6800

ENTRYPOINT ["/init.sh"]

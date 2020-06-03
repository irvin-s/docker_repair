FROM alpine:3.2

MAINTAINER chrisdaish@gmail.com

RUN apk update \
    && apk add squid=3.5.4-r2 \
    && apk add curl \
    && rm -rf /var/cache/apk/*

COPY start-squid.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/start-squid.sh"]

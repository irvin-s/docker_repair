FROM alpine:3.8

RUN apk update \
  && apk add bash curl \
  && rm -rf /var/cache/apk/*

ADD ./config /config
ADD write-config.sh /write-config.sh

ENTRYPOINT ["/write-config.sh"]

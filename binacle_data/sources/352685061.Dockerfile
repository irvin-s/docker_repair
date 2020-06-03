FROM alpine:3.4

RUN \
  apk update && apk add netcat-openbsd bash && \
  rm -rf /tmp/* /var/cache/apk/*

ADD mon_router.sh reset_router.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/mon_router.sh"]

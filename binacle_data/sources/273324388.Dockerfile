FROM alpine:3.6
LABEL maintainer="Jose Armesto <jose@armesto.net>"

EXPOSE 8000

ENTRYPOINT ["/sbin/tini", "--", "/opt/app"]

RUN apk add --no-cache --update tini=0.14.0-r0 ca-certificates && \
    addgroup -S app && adduser -u 10001 -S -g /opt/app app && \
    rm -rf /var/cache/apk/* /tmp/*

USER app
ADD ["release/*-linux-*", "/opt/app"]

FROM kafebob/rpi-alpine-base:latest

LABEL maintainer="Luis Toubes <luis@toub.es>"

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8"

RUN apk update && \
    apk --no-cache add mariadb mariadb-client && \
    # clear cache
    rm -rf /var/cache/apk/*

COPY ./rootfs/. /

VOLUME /data
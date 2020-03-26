FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk add --update-cache \
        mongodb \
        mongodb-tools \
        && \
    rm -rf /var/cache/apk/*

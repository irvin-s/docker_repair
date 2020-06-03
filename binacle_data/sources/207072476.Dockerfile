FROM unocha/alpine-base-s6:3.4

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8

RUN apk add \
        --update-cache \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
        munin \
        munin-node \
        perl-net-cidr \
        perl-list-moreutils && \
    rm -rf /var/cache/apk/*

FROM dockette/alpine:3.8

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV NODEJS_VERSION=8.14.0

RUN echo '@main http://nl.alpinelinux.org/alpine/v3.8/main' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    # DEPENDENCIES #############################################################
    apk add --update bash git openssh curl && \
    # NODEJS ###################################################################
    apk add --update nodejs-current@main && \
    # CLEAN UP #################################################################
    rm -rf /var/cache/apk/*

CMD nodejs

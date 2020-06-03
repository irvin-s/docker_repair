FROM dockette/alpine:3.6

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV NODEJS_VERSION=6.10.3

RUN echo '@edge http://nl.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    # DEPENDENCIES #############################################################
    apk add --update bash git openssh curl && \
    # NODEJS ###################################################################
    apk add --update nodejs-npm@edge && \
    # CLEAN UP #################################################################
    rm -rf /var/cache/apk/*

CMD nodejs

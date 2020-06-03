FROM dockette/alpine:3.6

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV NODEJS_VERSION=7.10.1
ENV YARN_VERSION=0.27.5

RUN echo '@community http://nl.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    # DEPENDENCIES #############################################################
    apk add --update bash git openssh curl && \
    # NODEJS ###################################################################
    apk add --update nodejs-current-npm@community && \
    apk add --update yarn && \
    # CLEAN UP #################################################################
    rm -rf /var/cache/apk/*

CMD nodejs

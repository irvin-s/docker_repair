FROM dockette/alpine:3.7

MAINTAINER Milan Sulc <sulcmil@gmail.com>

RUN echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add nodejs-current@community nodejs-npm@community git && \
    rm -rf /var/cache/apk/*

CMD node

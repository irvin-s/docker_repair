FROM dockette/alpine:3.6

MAINTAINER Milan Sulc <sulcmil@gmail.com>

RUN apk update && apk upgrade && \
    apk add nodejs-npm git && \
    rm -rf /var/cache/apk/*

CMD node

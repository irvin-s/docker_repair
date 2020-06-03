FROM gliderlabs/alpine:3.3
MAINTAINER Adam K Dean <adamkdean@googlemail.com>

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

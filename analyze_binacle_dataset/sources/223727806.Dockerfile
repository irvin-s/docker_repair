FROM alpine
MAINTAINER Octoblu <docker@octoblu.com>

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

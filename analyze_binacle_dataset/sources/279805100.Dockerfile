FROM golang:1.9-alpine

ENV appdir /go/src/gin-api-boilerplate
RUN mkdir -p $appdir
WORKDIR $appdir

RUN echo http://mirrors.aliyun.com/alpine/v3.6/main > /etc/apk/repositories \
    && echo http://mirrors.aliyun.com/alpine/v3.6/main >> /etc/apk/repositories \
    && apk add --no-cache git make \
    && go get -v github.com/golang/dep/cmd/dep \
    && go get -v github.com/codegangsta/gin

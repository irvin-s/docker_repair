FROM openjdk:8u171-jre-alpine3.8 AS build

RUN apk --no-cache add \
  make \
  git \
  go \
  musl-dev

COPY codesearch-server.jar /
COPY /docker/web-server/Makefile /

RUN go get github.com/aelve/codesearch-engine/cmd/...
RUN rm -rf /var/cache/apk/*

ENV PATH /root/go/bin:$PATH

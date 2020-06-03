FROM openjdk:8u171-jre-alpine3.8 AS build

RUN apk --no-cache add \
  make \
  git \
  nodejs \
  nodejs-npm \
  go \
  musl-dev \
  curl \
  wget \
  ruby \
  ruby-json

COPY codesearch-core.jar /
COPY /scripts/update_index.rb /scripts/
COPY /docker/core/Makefile /
COPY /docker/core/wait-for /

RUN chmod +x wait-for
RUN go get github.com/aelve/codesearch-engine/cmd/...
RUN rm -rf /var/cache/apk/*

ENV PATH /root/go/bin:$PATH

FROM unocha/alpine-base-s6:3.4

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

RUN apk add --update-cache \
      openjdk7-jre && \
    rm -rf /var/cache/apk/*

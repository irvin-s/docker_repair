FROM alpine:latest
MAINTAINER pwittchen
USER root

RUN apk update
RUN apk fetch openjdk8
RUN apk add openjdk8

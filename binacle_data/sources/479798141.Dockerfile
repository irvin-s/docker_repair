FROM ruby:2.3-alpine

MAINTAINER Adrian Moreno <adrian.moreno@emc.com>

COPY . /usr/src/app

WORKDIR /usr/src/app

RUN apk --update add git
RUN apk --update add --virtual build_deps \
 build-base ruby-dev libc-dev linux-headers openssl-dev &&\
 bundle &&\
 gem install uploader &&\
 apk del build_deps

ENTRYPOINT [ "uploader" ]

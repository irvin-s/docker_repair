FROM ruby:2.3.1-alpine@sha256:8d5ca285f1a24ed333aad70cfa54157f77ff130f810c91d5664e98a093d751bc

MAINTAINER Clement Labbe <clement.labbe@rea-group.com>

RUN apk add --update \
    make \
    g++ \
    diffutils \
    git \
    ca-certificates && \
    rm /var/cache/apk/* && \
    rm -rf /usr/share/ri

RUN echo -e 'gem: --no-rdoc --no-ri' > /etc/gemrc


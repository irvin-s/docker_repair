FROM ruby:2.4.0-alpine

RUN apk add --update git make g++ bash

RUN mkdir -p /reclame_aqui

WORKDIR /reclame_aqui

COPY . .

RUN gem install bundler -v 2.0.1
RUN bundle _2.0.1_ install
ENV BUNDLER_VERSION=2.0.1

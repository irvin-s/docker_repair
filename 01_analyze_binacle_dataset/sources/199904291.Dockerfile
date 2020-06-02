FROM ruby:2.2-alpine

ADD . /app
WORKDIR /app

RUN bundle install

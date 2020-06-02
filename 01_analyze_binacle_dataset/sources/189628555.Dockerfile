FROM ruby:2.4-alpine

RUN apk add --no-cache \
  build-base \
  git \
  nodejs \
  tzdata

WORKDIR /app

Add Gemfile /app/Gemfile
Add Gemfile.lock /app/Gemfile.lock
RUN bundle
ADD . /app

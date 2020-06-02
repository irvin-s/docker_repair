FROM ruby:2.3-alpine

RUN apk update && apk add git g++ make

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN bundle config --global frozen 1 && bundle install --no-deployment

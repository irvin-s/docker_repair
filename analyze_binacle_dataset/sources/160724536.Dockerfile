FROM ruby:2.5-alpine

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN apk --no-cache add build-base && \
    bundle install --without=development --deployment && \
    apk del build-base

COPY . /usr/src/app
CMD bundle exec ruby bot.rb

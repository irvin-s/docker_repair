FROM ruby:2.5.0-alpine
RUN apk add --update \
  build-base \
  && rm -rf /var/cache/apk/*

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV RACK_ENV production

COPY Gemfile Gemfile.lock /usr/src/app/
RUN bundle install --without test --jobs 2

COPY . /usr/src/app
CMD bundle exec puma -C config/puma.rb

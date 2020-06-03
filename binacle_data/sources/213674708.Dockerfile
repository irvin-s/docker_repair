FROM cloudgear/ruby:2.2
MAINTAINER Georg Kunz, CloudGear <contact@cloudgear.net>

# throw errors if Gemfile is newer than Gemfile.lock
RUN bundle config --global frozen 1 && \
    mkdir -p /usr/src/app

WORKDIR /usr/src/app

ONBUILD COPY Gemfile      /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/
ONBUILD RUN bundle install --deployment

ONBUILD COPY . /usr/src/app

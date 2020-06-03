FROM ruby:2.3.3
MAINTAINER andreskal@gmail.com


RUN apt-get update && apt-get install -y \
zlib1g-dev \
build-essential \
libssl-dev \
libyaml-dev \
libsqlite3-dev \
sqlite3 \
libxml2-dev \
libxslt1-dev \
libcurl4-openssl-dev \
python-software-properties \
libffi-dev \
nodejs-legacy \
libreadline-dev \
libmysqlclient-dev

RUN mkdir -p /app
RUN mkdir -p /app/pids
RUN mkdir -p /app/sockets

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler

RUN bundle install --jobs 20 --retry 5  --without test

COPY . ./

ARG ENVIRONMENT

ENV RAILS_ENV $ENVIRONMENT

CMD bundle exec puma

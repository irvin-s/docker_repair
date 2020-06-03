FROM ruby:2.5

LABEL maintainer="jani@google.com"

RUN apt-get install -y default-libmysqlclient-dev

RUN gem install mysql2

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . /usr/src/app


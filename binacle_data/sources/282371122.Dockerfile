FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY ./ /usr/src/app

RUN bundle install
ADD . /usr/src/app

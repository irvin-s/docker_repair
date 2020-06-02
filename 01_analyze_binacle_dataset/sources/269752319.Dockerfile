FROM ruby:2.3.1
MAINTAINER Walter Alves <walter.arruda.alves@gmail.com>

RUN apt-get update -qq && apt-get install -y libpq-dev nodejs
RUN mkdir /upmeapp
WORKDIR /upmeapp
COPY . /upmeapp
RUN rm /upmeapp/Gemfile.lock & touch /upmeapp/Gemfile.lock
RUN bundle install

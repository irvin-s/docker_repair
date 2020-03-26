FROM ruby:2.5.1

RUN gem install cucumber

RUN mkdir /work
WORKDIR /work

COPY .wire .

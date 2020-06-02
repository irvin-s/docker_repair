FROM ruby:2.1

RUN apt-get update
RUN apt-get install -y protobuf-compiler

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN bundle install

CMD bundle exec rake

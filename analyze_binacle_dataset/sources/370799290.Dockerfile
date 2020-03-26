FROM ruby:slim
RUN apt-get update -qq && apt-get install -y  \
  git \
  build-essential \
  libpq-dev \
  curl
RUN gem install bundler
RUN mkdir /stretchy
WORKDIR /stretchy
ADD . /stretchy
RUN bundle install


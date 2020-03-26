FROM ruby:2.3.3
MAINTAINER Terrance Niechciol <terrance@remind101.com>

RUN apt-get update && \
  apt-get install -y vim && \
  apt-get -q -y clean && \
  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

LABEL app=request_id

RUN gem install bundler
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /home/app
WORKDIR /home/app

COPY Gemfile /home/app/
COPY Gemfile.lock /home/app/
RUN bundle install --jobs 4 --retry 3

COPY . /home/app

CMD ["bundle", "exec", "rails", "console"]

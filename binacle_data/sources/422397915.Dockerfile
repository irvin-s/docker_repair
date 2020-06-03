# The current stack is not compatible with Ruby 2.4 for similar reasons to this https://github.com/backup/backup/issues/820.
FROM ruby:2.3

RUN mkdir /app
WORKDIR /app

RUN apt-get update && apt-get install -y \
  nodejs \
  unzip \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

COPY Gemfile* /app/

RUN bundle install

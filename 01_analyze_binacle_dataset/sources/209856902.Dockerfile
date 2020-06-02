# Base info
FROM ruby:2.3.0-slim
MAINTAINER Angelmmiguel <angel@laux.es>

# Install
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /kip
WORKDIR /kip
ADD Gemfile /kip/Gemfile
ADD Gemfile.lock /kip/Gemfile.lock
RUN bundle install --without development test

# Add the kip
ADD . /kip
RUN rake assets:precompile

CMD ["bundle exec rails s", "-p 3000", "-b '0.0.0.0'"]

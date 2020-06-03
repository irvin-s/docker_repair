FROM ruby:2.4.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /stuy-spec-api
WORKDIR /stuy-spec-api
ADD Gemfile /stuy-spec-api/Gemfile
ADD Gemfile.lock /stuy-spec-api/Gemfile.lock
RUN gem install bundler
RUN bundle install
ADD . /stuy-spec-api

FROM ruby:2.3.1-alpine

# Install libraries needed for native extensions
RUN apk add --no-cache build-base libxml2-dev libxslt-dev postgresql-dev nodejs tzdata

RUN mkdir /womenrising
WORKDIR /womenrising

# Grab the latest version of Bundler
RUN gem install bundler

# Configure nokogiri to use libxml2-dev and libxslt-dev
# As of nokogiri 1.6.8, the --use-system-libraries work-around is unnecessary.
RUN bundle config build.nokogiri --use-system-libraries

ADD Gemfile /womenrising/Gemfile
ADD Gemfile.lock /womenrising/Gemfile.lock

RUN bundle install

ADD . /womenrising

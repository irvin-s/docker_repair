FROM ruby:2.4.2

MAINTAINER Andrew Mason <andrew@fixedpoint.xyz>

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-client && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /the_jolly_advisor

ADD Gemfile /the_jolly_advisor/Gemfile
ADD Gemfile.lock /the_jolly_advisor/Gemfile.lock
RUN bundle install --with test

ADD . /the_jolly_advisor

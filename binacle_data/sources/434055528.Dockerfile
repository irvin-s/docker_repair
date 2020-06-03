FROM ruby:2.2.3
MAINTAINER Konstantin Zub "hello@zubkonst.com"

RUN mkdir /pirozhki
WORKDIR /pirozhki

ADD Gemfile /pirozhki/Gemfile
ADD Gemfile.lock /pirozhki/Gemfile.lock
RUN bundle install

ADD . /pirozhki

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

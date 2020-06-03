FROM debian:wheezy

MAINTAINER Graylog, Inc. <hello@graylog.com>

RUN apt-get clean
RUN apt-get update
RUN apt-get install -y ruby1.9.1 ruby1.9.1-dev build-essential curl lsb-release
RUN gem install fpm-cookery --no-ri --no-rdoc

# Install some package dependencies to avoid installing them every time.
RUN apt-get install -y openjdk-7-jre-headless uuid-runtime

# Remove cached packages and metadata to keep images small.
RUN apt-get clean

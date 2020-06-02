FROM ubuntu:16.04

MAINTAINER Graylog, Inc. <hello@graylog.com>

RUN apt-get clean
RUN apt-get update
RUN apt-get install -y ruby ruby2.3 ruby2.3-dev build-essential curl lsb-release
RUN gem install fpm-cookery --no-ri --no-rdoc

# Install some package dependencies to avoid installing them every time.
RUN apt-get install -y openjdk-8-jre-headless uuid-runtime

# Remove cached packages and metadata to keep images small.
RUN apt-get clean

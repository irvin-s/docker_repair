# Ruby/Rails Dependencies (gewo/ruby-dependencies)
FROM gewo/rvm
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen'\
    | tee /etc/apt/sources.list.d/10gen.list

RUN apt-get update

# Nokogiri
RUN apt-get install -y libyaml-dev libxml2 libxml2-dev libxslt1-dev

# RMagick system dependencies
RUN apt-get install -y libmagickwand5 libmagickwand-dev imagemagick

# ExecJS Runtime
RUN apt-get install -y nodejs

# MySQL gem dependencies and client
RUN apt-get install -y libmysqlclient-dev mysql-client-5.6

# Headless Selenium Tests
RUN apt-get install -y firefox xvfb

# Java Runtime (for Solr, ...)
RUN apt-get install -y openjdk-7-jre-headless

# Install MongoDB Clients
ENV MONGODB_VERSION 2.4.6
RUN apt-get install -y mongodb-10gen=${MONGODB_VERSION}

# Redis Client
RUN apt-get install -y redis-tools

# Postgres Client and libs
RUN apt-get install -y libgmp10-dev libpq-dev postgresql-client

# Unzip
RUN apt-get install -y unzip

RUN apt-get clean

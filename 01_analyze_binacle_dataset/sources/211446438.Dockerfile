FROM ruby:latest
FROM irfanah/appium-ruby:latest

MAINTAINER irfan@critick.io

ENV PHANTOM_VERSION="phantomjs-2.1.1-linux-x86_64"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev && \
    curl -L -O https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_VERSION.tar.bz2 && \
    tar xvjf $PHANTOM_VERSION.tar.bz2 && \
    mv $PHANTOM_VERSION /usr/local/share && \
    ln -sf /usr/local/share/$PHANTOM_VERSION/bin/phantomjs /usr/local/bin

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir -p /opt/testing
WORKDIR /opt/testing
ADD . /opt/testing

RUN gem install bundler
RUN gem install nokogiri

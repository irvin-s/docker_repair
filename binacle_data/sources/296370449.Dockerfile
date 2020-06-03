FROM ubuntu:16.04
MAINTAINER Zack Siri <zack@codemy.net>

# set the locale for Ruby / Rails
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update && apt-get install -y git-core sudo curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libpq-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common python-software-properties libffi-dev

# install ruby from package
RUN add-apt-repository ppa:brightbox/ruby-ng && apt-get update && apt-get install -y ruby2.3 ruby2.3-dev
RUN gem update --system
RUN gem install bundler

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && apt-get update && apt-get install -y nodejs

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
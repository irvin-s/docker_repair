# Codelitt's Ruby image based off Phusion's baseimage
#
# This image is tagged in Docker Hub as codelittin/ruby:[ruby_version]-phusion
FROM phusion/baseimage:0.9.19
MAINTAINER Codelitt, Inc.

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV LANGUAGE en_US.UTF-8

# Install dependencies
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y ruby2.3 \
    ruby2.3-dev \
    build-essential \
    curl \
    git \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt-dev \
    libpq-dev
RUN rm -rf /var/lib/apt/lists/*

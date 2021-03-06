FROM ubuntu:16.04

RUN apt-get update -y && apt-get install -y \
    # common stuff
        git \
        wget \
        unzip \
        python3.5 \
        python3-pip \
        python-setuptools \
        python3-venv \
    # fpm
        ruby \
        ruby-dev \
        rubygems \
        gcc \
        make

# install fpm
RUN gem install --no-ri --no-rdoc rake fpm

WORKDIR /root

ADD . /root

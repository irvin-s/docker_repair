FROM ruby:2.4.0

RUN \
  apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y \
    build-essential \
    sudo \
    iceweasel \
    chromium \
    xvfb

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs

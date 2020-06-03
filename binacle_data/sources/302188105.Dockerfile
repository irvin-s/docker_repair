FROM ubuntu:16.04

RUN apt-get update && \
  apt-get install -y \
# install basics
  vim \
  wget \
  curl \
  gettext \
  slay \
  python \
  python-pip \
# install zimbra pre-requisites
  ant \
  ant-contrib \
  build-essential \
  git \
  maven \
  openjdk-8-jdk \
  ruby \
  net-tools \
  rsyslog \
  software-properties-common \
  npm

RUN npm install -g n && \
    n latest

RUN npm install -g junit-merge

RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

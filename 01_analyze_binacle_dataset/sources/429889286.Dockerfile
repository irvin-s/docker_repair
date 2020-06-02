# Creates openstack common base image
#
# Author: Paul Czarkowski
# Date: 08/16/2014

FROM ubuntu:trusty
MAINTAINER Paul Czarkowski "paul@paulcz.net"

ENV DEBIAN_FRONTEND=noninteractive ETCD=v2.0.10 CONFD=0.9.0

# Base Deps
RUN \
  apt-get update && apt-get install -yq \
  make \
  ca-certificates \
  net-tools \
  sudo \
  wget \
  curl \
  vim \
  strace \
  lsof \
  netcat \
  lsb-release \
  locales \
  socat \
  runit \
  git \
  bzip2 \
  python-dev \
  libxml2-dev \
  libxslt1-dev \
  zlib1g-dev \
  libreadline-dev \
  libmysqlclient-dev \
  libsqlite3-dev \
  libdb-dev \
  python-mysqldb \
  build-essential \
  mysql-client \
  libffi-dev \
  less \
  libssl-dev \
  --no-install-recommends && \
  locale-gen en_US.UTF-8 && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py

RUN python /tmp/get-pip.py && pip install virtualenv

# install etcdctl and confd
RUN \
  curl -sSL -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v$CONFD/confd-$CONFD-linux-amd64 \
  && chmod +x /usr/local/bin/confd && \
  cd /tmp && \
  curl -sSL https://github.com/coreos/etcd/releases/download/$ETCD/etcd-$ETCD-linux-amd64.tar.gz | tar xzf - && \
  cp etcd-$ETCD-linux-amd64/etcdctl /usr/bin/etcdctl && chmod +x /usr/bin/etcdctl && rm -rf /tmp/etcd*

WORKDIR /app

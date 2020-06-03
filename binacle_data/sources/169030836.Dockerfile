# This file creates a container that runs Database (Percona) with Galera Replication.
#
# Author: Paul Czarkowski
# Date: 08/16/2014

FROM debian:wheezy
MAINTAINER Paul Czarkowski "paul@paulcz.net"

# Base Deps
RUN \
  apt-get update && apt-get install -yq \
  make \
  ca-certificates \
  net-tools \
  sudo \
  wget \
  vim \
  strace \
  lsof \
  netcat \
  lsb-release \
  locales \
  socat \
  --no-install-recommends

# generate a local to suppress warnings
RUN locale-gen en_US.UTF-8

RUN \
  wget -O - http://download.gluster.org/pub/gluster/glusterfs/3.5/LATEST/Debian/pubkey.gpg | apt-key add - && \
  echo "deb http://download.gluster.org/pub/gluster/glusterfs/3.5/LATEST/Debian/wheezy/apt wheezy main" > /etc/apt/sources.list.d/gluster.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y glusterfs-server attr

# download latest stable etcdctl
ADD https://s3-us-west-2.amazonaws.com/opdemand/etcdctl-v0.4.5 /usr/local/bin/etcdctl
RUN chmod +x /usr/local/bin/etcdctl

# install confd
ADD https://s3-us-west-2.amazonaws.com/opdemand/confd-v0.5.0-json /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

# Define mountable directories.
VOLUME ["/export"]

ADD . /app

# Define working directory.
WORKDIR /app

RUN chmod +x /app/bin/*

# Define default command.
CMD ["/app/bin/boot"]

# Expose ports.
EXPOSE 111 24007 2049 38465 38466 38467 1110 4045
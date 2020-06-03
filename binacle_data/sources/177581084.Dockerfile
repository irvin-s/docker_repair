# This file creates a container that runs Elasticsearch
#
# Author: Paul Czarkowski
# Date: 08/16/2014

FROM java:7

MAINTAINER Paul Czarkowski "paul@paulcz.net"

RUN \
  apt-get -yqq update && \
  apt-get -yqq install curl wget runit netcat net-tools && \
  rm -rf /var/lib/apt/lists/*

ENV ETCD=v2.0.10 CONFD=0.9.0

# install etcdctl and confd
RUN \
  curl -sSL -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v$CONFD/confd-$CONFD-linux-amd64 \
  && chmod +x /usr/local/bin/confd

RUN \
  cd /tmp && \
  curl -sSL https://github.com/coreos/etcd/releases/download/$ETCD/etcd-$ETCD-linux-amd64.tar.gz | tar xzf - && \
  cp etcd-$ETCD-linux-amd64/etcdctl /usr/bin/etcdctl && chmod +x /usr/bin/etcdctl && rm -rf /tmp/etcd*

WORKDIR /app

ENV ELASTICSEARCH elasticsearch-1.5.2

# install Elasticsearch
RUN \
  cd /opt && \
  curl -sSL https://download.elastic.co/elasticsearch/elasticsearch/$ELASTICSEARCH.tar.gz \
  | tar xzf - && \
  cd - && \
  ln -s /opt/$ELASTICSEARCH /opt/elasticsearch && \
  mkdir /data

ADD . /app

RUN \
  chmod +x /app/bin/*

# Define default command.
CMD ["/app/bin/boot"]

VOLUME /data

# Expose ports.
EXPOSE 9200 9300

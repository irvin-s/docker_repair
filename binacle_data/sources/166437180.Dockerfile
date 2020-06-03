FROM ubuntu:14.04

MAINTAINER James R. Carr <james@zapier.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install git wget unzip -yq


RUN git clone https://github.com/jamescarr/mcrouter.git /tmp/mcrouter

RUN cd /tmp/mcrouter/mcrouter/scripts \
  && ./install_ubuntu_14.04.sh /usr/local/share

RUN ln -s /usr/local/share/install/bin/mcrouter /usr/local/bin/mcrouter

## Cleanup!
RUN rm -rf /tmp/*
ENV DEBIAN_FRONTEND newt

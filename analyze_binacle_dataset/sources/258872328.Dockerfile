# Ryu SDN Framework
#
# VERSION 0.0.1

FROM ubuntu:16.04

MAINTAINER FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

ENV HOME /root
WORKDIR /root

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    python-setuptools \
    python-pip \
    python-eventlet \
    python-lxml \
    python-msgpack \
    iproute2 \
 && rm -rf /var/lib/apt/lists/* \
 && curl -kL https://github.com/osrg/ryu/archive/master.tar.gz | tar -xvz \
 && mv ryu-master ryu \
 && cd ryu \
 && pip install -r tools/pip-requires \
 && python setup.py install

FROM ubuntu:16.04

ENV EXABGP_VERSION 4.0.5

ENV HOME /root
WORKDIR /root

RUN apt-get update && apt-get install -qy --no-install-recommends \
# Python
    python3-pip \
    python3-setuptools \
# Utility
    iproute2 \
 && rm -rf /var/lib/apt/lists/* \
 && pip3 install exabgp==${EXABGP_VERSION}


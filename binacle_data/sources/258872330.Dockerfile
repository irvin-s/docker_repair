FROM ubuntu:16.04

ENV YABGP_VERSION 0.4.0

ENV HOME /root
WORKDIR /root

RUN apt-get update && apt-get install -qy --no-install-recommends \
# For calling REST API of YABGP
    curl \
# Utility
    iproute2 \
# Python
    python-pip \
    python-setuptools \
# For building Python C extension
    gcc \
    python-dev \
# Removes APT caches
 && rm -rf /var/lib/apt/lists/* \
# Installs YABGP via pip
 && pip install yabgp==${YABGP_VERSION}

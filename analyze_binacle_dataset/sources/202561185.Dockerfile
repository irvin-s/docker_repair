FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q  \
    bladerf \
    git \
    libbladerf0 \ 
    libbladerf-dev \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

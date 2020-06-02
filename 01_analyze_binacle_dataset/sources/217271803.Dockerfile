FROM debian:jessie

MAINTAINER snowdream <yanghui1986527@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get -qq update && \
    apt-get -qqy install --no-install-recommends \
       build-essential \
       autotools-dev  \
       cmake  &&\
     rm -rf /var/lib/apt/lists/*

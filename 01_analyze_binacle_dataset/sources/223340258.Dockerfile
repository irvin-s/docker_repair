FROM ubuntu:14.04
MAINTAINER Norio Nomura <norio.nomura@gmail.com>

# Install Dependencies

RUN apt-get update && \
    apt-get install -y \
      clang-3.6 \
      curl \
      git \
      libblocksruntime0 \
      libcurl4-openssl-dev \
      libedit2 \
      libicu52 \
      libkqueue0 \
      libpython2.7-dev \
      libxml2 \
      python2.7 \
      uuid-dev \
      && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM ubuntu:xenial

RUN apt-get update && \
  apt-get install -y \
  tar wget git \
  openjdk-8-jdk autoconf libtool \
  build-essential python-dev python-boto \
  libcurl4-nss-dev libsasl2-dev libsasl2-modules maven libapr1-dev libsvn-dev \
  libmicrohttpd-dev libssl-dev libunwind-dev libgflags-dev

RUN apt-get install -y zlib1g-dev cmake

RUN git clone --single-branch --branch 1.0.4 https://github.com/apache/mesos.git

RUN cd mesos && \
  ./bootstrap && \
  mkdir -p build && \
  cd build && \
  ../configure && \
  make -j $(nproc)

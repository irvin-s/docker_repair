# Build Image for Gitlab CI

FROM ubuntu:14.04

MAINTAINER Elliott Slaughter <slaughter@cs.stanford.edu>

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 && \
    apt-get update -qq && \
    apt-get install -qq software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    add-apt-repository ppa:pypy/ppa -y && \
    apt-get update -qq && \
    apt-get install -qq \
      build-essential git time wget \
      libpython-dev python-pip libpython3-dev python3-pip pypy \
      g++-4.8 g++-4.9 g++-5 g++-6 g++-7 \
      gcc-4.9-multilib g++-4.9-multilib \
      clang-3.5 libclang-3.5-dev llvm-3.5-dev \
      clang-3.8 libclang-3.8-dev llvm-3.8-dev \
      libncurses5-dev \
      zlib1g-dev zlib1g-dev:i386 \
      mpich2 libmpich-dev \
      mesa-common-dev \
      libblas-dev liblapack-dev libhdf5-dev \
      libssl-dev \
      gdb vim && \
    apt-get clean && \
    pip install --upgrade setuptools && \
    pip install cffi github3.py numpy qualname && \
    pip3 install --upgrade setuptools && \
    pip3 install cffi github3.py numpy qualname

RUN wget https://cmake.org/files/v3.6/cmake-3.6.2-Linux-x86_64.tar.gz && \
    echo "dd9d8d57b66109d4bac6eef9209beb94608a185c  cmake-3.6.2-Linux-x86_64.tar.gz" | shasum --check && \
    tar xfzC cmake-3.6.2-Linux-x86_64.tar.gz /usr/local --strip-components=1 && \
    rm cmake-3.6.2-Linux-x86_64.tar.gz

RUN git clone -b luajit2.1 https://github.com/StanfordLegion/terra.git && \
    cp -r terra terra35 && \
    LLVM_CONFIG=llvm-config-3.5 make -C terra35 REEXPORT_LLVM_COMPONENTS="irreader jit mcjit x86" && \
    mkdir /usr/local/terra35 && \
    make -C terra35 install PREFIX=/usr/local/terra35 && \
    rm -rf terra35 && \
    cp -r terra terra38 && \
    LLVM_CONFIG=llvm-config-3.8 make -C terra38 REEXPORT_LLVM_COMPONENTS="irreader mcjit x86" && \
    mkdir /usr/local/terra38 && \
    make -C terra38 install PREFIX=/usr/local/terra38 && \
    rm -rf terra38 && \
    rm -rf terra

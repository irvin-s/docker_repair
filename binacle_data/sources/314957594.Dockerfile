FROM ubuntu:16.04

MAINTAINER Zach Gray (zgray@scal.io)
LABEL maintainer="Zach Gray <zgray@scal.io>"
LABEL Description="Dockerized Swift for TensorFlow"

# Install related packages and set LLVM 3.8 as the compiler
RUN apt-get -q update && \
    apt-get -q install -y \
    make \
    libc6-dev \
    clang-3.8 \
    curl \
    libedit-dev \
    libpython2.7 \
    libpython-dev  \
    libncurses5-dev \
    libicu-dev \
    libssl-dev \
    libxml2 \
    tzdata \
    git \
    libcurl4-openssl-dev \
    pkg-config \
    && update-alternatives --quiet --install /usr/bin/clang clang /usr/bin/clang-3.8 100 \
    && update-alternatives --quiet --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100 \
    && rm -r /var/lib/apt/lists/*

# Install Swift for TensorFlow:

# Define SWIFT_TF_URL as an arg that can be passed by users if needed
ARG SWIFT_TF_URL=https://storage.googleapis.com/swift-tensorflow/ubuntu16.04/swift-tensorflow-DEVELOPMENT-2019-01-04-a-ubuntu16.04.tar.gz

RUN curl -fSsL $SWIFT_TF_URL -o swift-tensorflow.tar.gz \
    && tar xzf swift-tensorflow.tar.gz --directory / \
    && rm swift-tensorflow.tar.gz

# Version DEVELOPMENT-2019-01-04 needs this fix
RUN mv -n /usr/lib/libBlocksRuntime.so  /usr/lib/libBlocksRuntime.so.0 && ldconfig

RUN swift --version

RUN cd /usr/src
WORKDIR /usr/src

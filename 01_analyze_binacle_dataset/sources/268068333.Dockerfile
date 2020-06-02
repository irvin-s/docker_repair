# Copyright (c) 2015 Jimmy Cuadra
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# This Dockerfile is an adaption of the one written by Jimmy Cuadra
# (https://github.com/jimmycuadra/docker-rust). The main change is that we
# depend on a different base image.
FROM ubuntu:18.04

ENV USER root
ENV RUST_VERSION=1.27.1

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    openssh-client \
    libssl-dev \
    pkg-config \
    python \
    python-dev \
    python-pip \
    openjdk-8-jdk-headless \
    llvm-6.0 \
    llvm-6.0-dev \
    clang-6.0 \
    zlib1g-dev && \
  pip install numpy && \
  curl -sO https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init && \
  chmod +x rustup-init && \
  ./rustup-init -y --default-toolchain $RUST_VERSION --no-modify-path && \
  ln -s /usr/bin/llvm-config-6.0 /usr/local/bin/llvm-config && \
  DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y curl && \
  DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
  rm -rf \
    rustup-init \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* && \
  mkdir /source

ENV PATH $PATH:/root/.cargo/bin
WORKDIR /source
CMD ["/bin/bash"]

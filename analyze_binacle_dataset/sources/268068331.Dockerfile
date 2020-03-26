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

# This Dockerfile is an mashup of the dockerfiles written by Jimmy Cuadra
# (https://github.com/jimmycuadra/docker-rust) and by Andrew Dunham
# (https://github.com/andrew-d/docker-osxcross).

# Depend on Unbuntu 17.04 to avoid a bug around compiling the compilter_rt
# See: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=819072
FROM ubuntu:17.04

ENV USER root

# Install (most) dependencies.
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    openssh-client \
    libssl-dev \
    pkg-config \
    autotools-dev \
    automake \
    cmake \
    libfuse-dev \
    clang \
    python \
    file \
    llvm-3.8 \
    llvm-3.8-dev \
    clang-3.8

# Install Rust
ENV RUST_VERSION=1.19.0
RUN curl -sO https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init && \
  chmod +x rustup-init && \
  ./rustup-init -y --default-toolchain $RUST_VERSION --no-modify-path
ENV PATH $PATH:/root/.cargo/bin

# Install OSXCROSS
#
# NOTE: The Docker Hub's build machines run varying types of CPUs, so an image
# built with `-march=native` on one of those may not run on every machine - I
# ran into this problem when the images wouldn't run on my 2013-era Macbook
# Pro. As such, we remove this flag entirely.
ENV OSXCROSS_SDK_VERSION=10.11
ENV OSX_VERSION_MIN=10.7
RUN mkdir /opt/osxcross && \
  cd /opt && \
  git clone https://github.com/tpoechtrager/osxcross.git && \
  cd osxcross && \
  git checkout 474f359d2f27ff68916a064f0138c9188c63db7d && \
  sed -i -e 's|-march=native||g' ./build_clang.sh ./wrapper/build.sh && \
  ./tools/get_dependencies.sh && \
  curl -L -o ./tarballs/MacOSX${OSXCROSS_SDK_VERSION}.sdk.tar.xz \
    https://s3.amazonaws.com/andrew-osx-sdks/MacOSX${OSXCROSS_SDK_VERSION}.sdk.tar.xz && \
  yes | PORTABLE=true ./build.sh && \
  ./build_compiler_rt.sh

ENV PATH $PATH:/opt/osxcross/target/bin

# Install Rust toolchain for OSX
RUN rustup target add x86_64-apple-darwin
COPY config /root/.cargo

# Make sure Weld uses the correct version of LLVM.
RUN ln -s /usr/bin/llvm-config-3.8 /usr/local/bin/llvm-config

# Cleanup
RUN DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y curl && \
  DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
  rm -rf \
    rustup-init \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

# Create the work directory
RUN mkdir /source
WORKDIR /source
CMD ["/bin/bash"]

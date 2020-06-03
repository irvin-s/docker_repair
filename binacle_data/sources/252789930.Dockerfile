FROM ubuntu:16.04  
ARG BUILD_DIR=/build  
  
# Basic packages needed to download dependencies and unpack them.  
RUN apt-get update && apt-get install -y \  
bzip2 \  
perl \  
tar \  
wget \  
xz-utils \  
&& rm -rf /var/lib/apt/lists/*  
  
# Install packages necessary for compilation.  
RUN apt-get update && apt-get install -y \  
autoconf \  
automake \  
git \  
bash \  
build-essential \  
cmake \  
curl \  
gawk \  
libtool \  
lsb-release \  
pkg-config \  
sudo \  
tar \  
texi2html \  
yasm \  
xutils-dev \  
musl \  
musl-tools \  
&& rm -rf /var/lib/apt/lists/*  
  
# Copy the build scripts.  
COPY build.sh download.pl env.source fetchurl $BUILD_DIR/  
  
# Build all dependencies  
RUN cd $BUILD_DIR && ./build.sh -j6  
  
# Setup rust  
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable \  
&& /root/.cargo/bin/rustup target add x86_64-unknown-linux-musl  
  
# OpenSSL compilation variables (for rust)  
ENV OPENSSL_DIR=$BUILD_DIR/target \  
OPENSSL_INCLUDE_DIR=$BUILD_DIR/target/include/ \  
DEP_OPENSSL_INCLUDE=$BUILD_DIR/target/include/ \  
OPENSSL_LIB_DIR=$BUILD_DIR/target/lib/ \  
OPENSSL_STATIC=1  
# FFmpeg compilation variables (for rust)  
ENV FFMPEG_DIR=$BUILD_DIR/target  
  
# Cleanup stuff  
RUN rm -rf $BUILD_DIR/dep  
RUN rm -rf $BUILD_DIR/bin  
RUN rm -rf $BUILD_DIR/dl  
  
# Copy the kawa build script  
COPY build-kawa.sh $BUILD_DIR/  
  
CMD cd $BUILD_DIR; /bin/bash  


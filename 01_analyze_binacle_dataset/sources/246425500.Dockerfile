#
# Dockerfile_afi
# Builds docker container where AFI client can be compiled and run
#
# Advanced Forwarding Interface : AFI client examples
#
# Created by Sandesh Kumar Sodhi, January 2017
# Copyright (c) [2017] Juniper Networks, Inc. All rights reserved.
#
# All rights reserved.
#
# Notice and Disclaimer: This code is licensed to you under the Apache
# License 2.0 (the "License"). You may not use this code except in compliance
# with the License. This code is not an official Juniper product. You can
# obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Third-Party Code: This code may depend on other components under separate
# copyright notice and license terms. Your use of the source code for those
# components is subject to the terms and conditions of the respective license
# as noted in the Third-Party source code file.
#

FROM ubuntu:14.04.4
LABEL maintainer "Sandesh Kumar Sodhi"

#
# Build
#
# docker build -f Dockerfile_afi -t afi-docker .
#
# Run:
#
# docker run --name afi --privileged -i -t afi-docker /bin/bash
#

RUN apt-get update && apt-get install -y --no-install-recommends \
 ca-certificates \
 curl \
 ethtool \
 expect \
 git \
 gdebi-core \
 nmap \
 openssh-client \
 openssl \
 pkg-config \
 psmisc \
 sed \
 ssh \
 sshpass \
 tcpdump \
 telnet \
 tshark \
 tmux \
 unzip \
 vim \
 wget \
 autoconf automake libtool \
 bsdmainutils \
 build-essential \
 software-properties-common

#
# gcc 4.9
#
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install -y --no-install-recommends gcc-4.9 g++-4.9
RUN update-alternatives --remove gcc /usr/bin/gcc-4.8
RUN update-alternatives --remove gcc /usr/bin/gcc-4.8
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 40 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8


#
# Protobuf
# google-protobuf (v3.0.0-beta-3.3)
#
RUN mkdir -p /root/downloads
RUN cd /root/downloads && wget https://github.com/google/protobuf/archive/v3.0.0-beta-3.3.tar.gz
RUN cd /root/downloads && tar xzf v3.0.0-beta-3.3.tar.gz
RUN cd /root/downloads/protobuf-3.0.0-beta-3.3 && \
    curl -L -O https://github.com/google/googlemock/archive/release-1.7.0.zip && \
    unzip -q release-1.7.0.zip && \
    rm release-1.7.0.zip && \
    mv googlemock-release-1.7.0 gmock
RUN cd /root/downloads/protobuf-3.0.0-beta-3.3 && \
    curl -L -O https://github.com/google/googletest/archive/release-1.7.0.zip && \
    unzip -q release-1.7.0.zip && \
    rm release-1.7.0.zip && \
    mv googletest-release-1.7.0 gmock/gtest
RUN cd /root/downloads/protobuf-3.0.0-beta-3.3 && ./autogen.sh && ./configure && make && make install


#
# Install grpc
# grpc 0.15.1
#

RUN cd /root/downloads && git clone https://github.com/grpc/grpc.git
RUN cd /root/downloads/grpc && git checkout release-0_15_1
RUN cd /root/downloads/grpc && git submodule update --init
RUN cd /root/downloads/grpc && cp Makefile Makefile.orig
RUN cd /root/downloads/grpc && sed -i '109iREQUIRE_CUSTOM_LIBRARIES_dbg = 1' Makefile
RUN cd /root/downloads/grpc && sed -i -e 's/CONFIG ?= opt/CONFIG ?= dbg/g' Makefile
#
#diff Makefile.orig Makefile
#108a109
#> REQUIRE_CUSTOM_LIBRARIES_dbg = 1
#261c262
#< CONFIG ?= opt
#---
#> CONFIG ?= dbg
#
#
RUN cd /root/downloads/grpc && env LD_LIBRARY_PATH=/usr/local/lib make
RUN cd /root/downloads/grpc && env LD_LIBRARY_PATH=/usr/local/lib make install

#
# Boost
#
RUN apt-get update && apt-get install -y --no-install-recommends libboost-all-dev

#
# GTEST
#
RUN cd /root/downloads && wget https://github.com/google/googletest/archive/release-1.8.0.tar.gz
RUN cd /root/downloads && tar xzf release-1.8.0.tar.gz


COPY env/bash_aliases /root/.bash_aliases
COPY env/vimrc        /root/.vimrc
COPY env/tmux.conf    /root/.tmux.conf

COPY entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]

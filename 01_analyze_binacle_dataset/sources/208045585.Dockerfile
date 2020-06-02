#
# Copyright (c) 2018 Giorgio Zoppi <giorgio.zoppi@gmail.com>
#  
# Docker build environment for DTA
# Provides everything you need for development in any boost lib.
# (for linux, at least..)

FROM ubuntu:bionic
MAINTAINER Giorgio Zoppi <giorgio@apache.org>
ENV DEBIAN_FRONTEND noninteractive

# Load apt-utils first, fixes warnings

RUN apt-get update && \
	apt-get install -y build-essential git cmake autoconf libtool pkg-config apt-utils

# Hook in the Ubuntu PPA Repositories
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get update
# C++

RUN apt-get install -y \
      build-essential \
      clang \
      clang++-6 \
      cmake \
      g++-8 \
      libboost-system1.65.1 \ 
      libc++-dev \
      libc++-helpers \
      libstdc++6-8-dbg 
WORKDIR /opt/dtaservice
COPY --from=build /src/dtaservice ./
CMD ["./dtaservice"]



# This file describes the standard way to build the dependencies for Ostro bitbake build image
#
# Usage:
#
# docker build -t crops/ostro:deps -f Dockerfile.ostro.deps .

FROM debian:jessie
MAINTAINER Todor Minchev <todor.minchev@linux.intel.com>

# Install dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
  gawk \
  wget \
  git-core \
  diffstat \
  unzip \
  sysstat \
  texinfo \
  gcc-multilib \
  build-essential \
  chrpath \
  socat \
  python \
  libsdl1.2-dev  \
  cpio \
  sudo  \
  rsync && \
  apt-get clean && \
  echo "dash dash/sh boolean false" | debconf-set-selections && \
  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash


CMD /bin/bash

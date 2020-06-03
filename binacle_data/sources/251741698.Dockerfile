# Start with Ubuntu base image
FROM ubuntu:16.04

MAINTAINER Xiaohai Li <haixiaolee@gmail.com>

# Install basic deps
RUN apt-get update && apt-get install -y nano sudo wget build-essential cmake curl gfortran git  \
  libatlas-dev libavcodec-dev libavformat-dev libboost-all-dev libgtk2.0-dev libjpeg-dev   \
  liblapack-dev libswscale-dev pkg-config python-dev python-pip software-properties-common \
  graphicsmagick libgraphicsmagick1-dev python-numpy zip \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fetch and install cltorch
RUN git clone --recursive https://github.com/hughperkins/distro -b distro-cl /root/torch-cl && cd /root/torch-cl && bash install-deps

# Do not use gcc4.9! There's compatibility issues between gcc4.9, boost, and dlib
RUN cd /root/torch-cl && sed -i -- 's/gcc-4.9/gcc/g' install.sh && sed -i -- 's/g++-4.9/g++/g' install.sh && ./install.sh

RUN ln -s /root/torch-cl/install/bin/* /usr/local/bin

WORKDIR /root

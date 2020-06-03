# Start with NVidia cuDNN base image
FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

MAINTAINER Xiaohai Li <haixiaolee@gmail.com>

# Install basic deps
RUN apt-get update && apt-get install -y nano sudo wget build-essential cmake curl gfortran git  \
  libatlas-dev libavcodec-dev libavformat-dev libboost-all-dev libgtk2.0-dev libjpeg-dev   \
  liblapack-dev libswscale-dev pkg-config python-dev python-pip software-properties-common \
  graphicsmagick libgraphicsmagick1-dev python-numpy zip \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/torch/distro.git /root/torch --recursive && cd /root/torch && \
  bash install-deps

RUN cd /root/torch && ./install.sh

RUN ln -s /root/torch/install/bin/* /usr/local/bin

RUN luarocks install cutorch && luarocks install cunn && luarocks install cudnn

WORKDIR /root

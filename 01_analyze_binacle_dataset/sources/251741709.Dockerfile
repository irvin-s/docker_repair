# Start with NVidia CUDA base image
FROM nvidia/cuda:8.0-devel

MAINTAINER Xiaohai Li <haixiaolee@gmail.com>

# Install dependent packages
RUN apt-get -y update && apt-get install -y wget nano git build-essential yasm pkg-config

RUN git clone https://github.com/FFmpeg/nv-codec-headers /root/nv-codec-headers && \
  cd /root/nv-codec-headers &&\
  make -j8 && \
  make install -j8 && \
  cd /root && rm -rf nv-codec-headers

# Compile and install ffmpeg from source
RUN git clone https://github.com/FFmpeg/FFmpeg /root/ffmpeg && \
  cd /root/ffmpeg && ./configure \
  --enable-nonfree --disable-shared \
  --enable-nvenc --enable-cuda \
  --enable-cuvid --enable-libnpp \
  --extra-cflags=-I/usr/local/cuda/include \
  --extra-cflags=-I/usr/local/include \
  --extra-ldflags=-L/usr/local/cuda/lib64 && \
  make -j8 && \
  make install -j8 && \
  cd /root && rm -rf ffmpeg


ENV NVIDIA_DRIVER_CAPABILITIES video,compute,utility

WORKDIR /root

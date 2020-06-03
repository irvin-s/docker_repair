FROM ubuntu:16.04

RUN apt-get update && \
   apt-get install -y --no-install-recommends software-properties-common && \
   add-apt-repository ppa:lkoppel/robotics

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
       git g++ python3 \
       libblas-dev \
       liblapack-dev \
       liblapacke-dev \
       libopenmpi-dev \
       openmpi-bin \
       libeigen3-dev \
       libboost-all-dev \
       ca-certificates \
       wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://cmake.org/files/v3.12/cmake-3.12.0-Linux-x86_64.sh && \
   sh cmake-3.12.0-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir
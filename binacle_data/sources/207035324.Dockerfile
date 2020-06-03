FROM ubuntu:16.10
MAINTAINER Łukasz Hryniuk "lukasz.hryniuk@wp.pl"

RUN apt update && \
    apt install -y \
        cmake \
        gcc \
        g++ \
        libircclient-dev \
        libjsoncpp-dev \
        libsoci-dev \
        libssl-dev \
        python \
        wget

RUN wget https://github.com/mattgodbolt/seasocks/archive/v1.2.4.tar.gz && \
    tar xvfz v1.2.4.tar.gz && \
    cd seasocks-1.2.4 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    make clean

VOLUME ["/harpoon"]

# docker build -t lgarithm/crystalnet-dev:ubuntu -f Dockerfile.dev .

FROM ubuntu:bionic

ADD apt/sources.list.ustc /etc/apt/sources.list
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y cmake g++ python3 ruby golang-go valgrind cloc curl libopencv-dev git

ADD https://github.com/pjreddie/darknet/archive/master.zip /tmp/darknet
RUN cd /tmp && \
    unzip darknet && \
    cd darknet-master && \
    make -j $(nproc) && \
    cp -r include /usr && \
    cp libdarknet.a /usr/lib && \
    cd / && \
    rm -fr tmp/*

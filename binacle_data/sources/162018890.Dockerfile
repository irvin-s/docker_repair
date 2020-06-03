FROM ubuntu:cosmic AS executor64

RUN apt-get update && \
    apt-get install -y gcc g++ cmake \
        libboost-all-dev bison qt5-default libsdl2-dev \
        ninja-build

WORKDIR /files

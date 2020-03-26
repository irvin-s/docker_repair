FROM i386/ubuntu:cosmic AS executor32-buildtools

RUN apt-get update && \
    apt-get install -y gcc g++ cmake \
        libboost-all-dev bison qt5-default libsdl2-dev \
        ninja-build

WORKDIR /files


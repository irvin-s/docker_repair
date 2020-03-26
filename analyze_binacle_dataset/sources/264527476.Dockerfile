# adjusted from https://github.com/ethereum/cpp-ethereum/blob/develop/docker/Dockerfile
FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -y

# Nekonium dependencies
RUN apt-get install -qy build-essential g++-4.8 git cmake libboost-all-dev libcurl4-openssl-dev wget
RUN apt-get install -qy automake unzip libgmp-dev libtool libleveldb-dev yasm libminiupnpc-dev libreadline-dev scons
RUN apt-get install -qy libjsoncpp-dev libargtable2-dev

# NCurses based GUI (not optional though for a successful compilation, see https://github.com/ethereum/cpp-ethereum/issues/452 )
RUN apt-get install -qy libncurses5-dev

# Qt-based GUI
# RUN apt-get install -qy qtbase5-dev qt5-default qtdeclarative5-dev libqt5webkit5-dev

# Nekonium PPA
RUN apt-get install -qy software-properties-common
RUN add-apt-repository ppa:nekonium/nekonium
RUN apt-get update
RUN apt-get install -qy libcryptopp-dev libjson-rpc-cpp-dev

# Build Nekonium (HEADLESS)
RUN git clone --depth=1 --branch develop https://github.com/nekonium/cpp-nekonium
RUN mkdir -p cpp-nekonium/build
RUN cd cpp-nekonium/build && cmake .. -DCMAKE_BUILD_TYPE=Release -DHEADLESS=1 && make -j $(cat /proc/cpuinfo | grep processor | wc -l) && make install
RUN ldconfig

ENTRYPOINT ["/cpp-nekonium/build/test/createRandomTest"]


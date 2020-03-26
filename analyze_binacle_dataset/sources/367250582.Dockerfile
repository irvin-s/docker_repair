FROM ubuntu:14.04
MAINTAINER Tammy Yang <tammy@dt42.io>

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd ~ && \
    mkdir -p src && \
    cd src && \
    curl -L https://github.com/Itseez/opencv/archive/2.4.11.zip -o ocv.zip && \
    unzip ocv.zip && \
    cd opencv-2.4.11 && \
    mkdir release && \
    cd release && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D CUDA_GENERATION=Kepler \
          .. && \
    make -j8 && \
    make install

EXPOSE 9000


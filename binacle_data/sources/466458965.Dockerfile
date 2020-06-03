FROM ubuntu:18.04

WORKDIR /app

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    tzdata \
    cmake \
    g++ \
    git \
    libyaml-cpp-dev \
    libboost-dev \
    libceres-dev \
    libeigen3-dev libeigen3-doc \
    libopencv-*

RUN git clone https://github.com/chutsu/prototype
RUN cd prototype
RUN mkdir -p build
RUN cmake ..
RUN make

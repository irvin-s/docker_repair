FROM ubuntu:16.04

LABEL maintainer="boolivar@gmail.com"
LABEL description="Raspberry Pi Build Tools Image"

RUN apt-get update && apt-get install -y \
    bc \
    curl \
    gcc \
    git \
    make \
 && rm -rf /var/lib/apt/lists/*

ARG RPI_TOOLS=/opt/rpi-tools
ENV RPI_TOOLS ${RPI_TOOLS}
RUN git clone --depth 1 https://github.com/raspberrypi/tools.git ${RPI_TOOLS}

ADD build.sh /home/build.sh

ARG BUILD_DIR=/home/rpi
ENV BUILD_DIR ${BUILD_DIR}
VOLUME ${BUILD_DIR}

ARG KERNEL_DIR=/home/kernel
ENV KERNEL_DIR ${KERNEL_DIR}
VOLUME ${KERNEL_DIR}

ARG RPI_COMPILER=gcc-linaro-arm-linux-gnueabihf-raspbian-x64
ENV RPI_COMPILER ${RPI_COMPILER}
ENV CCPREFIX ${RPI_TOOLS}/arm-bcm2708/${RPI_COMPILER}/bin/arm-linux-gnueabihf-

ENTRYPOINT ["/home/build.sh"]

FROM resin/rpi-raspbian:wheezy

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    build-essential \
    gcc \
    libusb-dev \
    libdbus-1-dev \
    libglib2.0-dev \
    libudev-dev \
    libical-dev \
    libreadline-dev \
    wget \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate \
    www.kernel.org/pub/linux/bluetooth/bluez-5.11.tar.xz && \
    unxz bluez-5.11.tar.xz && \
    tar xvf bluez-5.11.tar && \
    cd bluez-5.11 && \
    ./configure --disable-systemd && \
    make && \
    make install 

RUN wget --no-check-certificate \
    https://s3.amazonaws.com/plugable/bin/fw-0a5c_21e8.hcd && \
    mkdir -p /lib/firmware/brcm && \
    mv fw-0a5c_21e8.hcd /lib/firmware/brcm/BCM20702A1-0a5c-21e8.hcd

#WORKDIR /data

CMD ["/bluez-5.11/tools/hciconfig"]

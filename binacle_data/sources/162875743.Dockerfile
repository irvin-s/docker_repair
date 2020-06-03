FROM debian:jessie
MAINTAINER Michael Pershyn michael.pershyn@gmail.com

LABEL Description="This image is used to build storm *.deb package"
# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

RUN mkdir /usr/src/app
VOLUME /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    git \
    g++ \
    uuid-dev \
    make \
    wget \
    libtool \
    openjdk-7-jdk \
    pkg-config \
    autoconf \
    automake \
    unzip \
    dpkg-dev \
    fakeroot \
    debhelper \
    dh-systemd

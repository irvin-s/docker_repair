FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
 && apt-get install -y \
        autoconf \
        automake \
        bison \
        debhelper \
        debian-keyring \
        default-jdk \
        devscripts \
        flex \
        gcc \
        git \
        libbson-dev \
        libcurl4-openssl-dev \
        libhiredis-dev \
        libltdl-dev \
        libmongoc-dev \
        libmysqlclient-dev \
        libpq-dev \
        libssl-dev \
        libtool \
        libvarnishapi-dev \
        libyajl-dev \
        lsb-release \
        make \
        pkg-config \
        python-dev \
 && rm -rf /var/lib/apt/lists/*

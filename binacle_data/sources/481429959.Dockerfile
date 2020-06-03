FROM ubuntu:xenial
#
# Install essential packages to build, test and debug
#
RUN \
    apt update -q && \
    apt install -y -q \
    libssl-dev \
    libsasl2-dev \
    libncurses5-dev \
    libnewt-dev \
    libxml2-dev \
    libsqlite3-dev \
    libjansson-dev \
    libcurl4-openssl-dev \
    libsrtp0-dev \
    pkg-config \
    build-essential \
    autoconf \
    uuid-dev \
    wget \
    gdb \
    git && \
    apt purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*

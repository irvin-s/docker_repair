# DOCKER-VERSION 1.5.0
# VERSION 0.2

FROM debian:wheezy
MAINTAINER James Badger <james@jamesbadger.ca>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    g++ \
    git-core \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libbz2-dev \
    libgeos++-dev \
    libgeos-dev \
    liblua5.2-dev \
    libpq-dev \
    libproj-dev \
    libprotobuf-c0-dev \
    libtool \
    libxml2-dev \
    lua5.2 \
    make \
    protobuf-c-compiler &&\
    rm -rf /var/lib/apt/lists/*

ENV HOME /root
ENV OSM2PGSQL_VERSION 0.87.2

RUN mkdir src &&\
    cd src &&\
    git clone --depth 1 --branch $OSM2PGSQL_VERSION https://github.com/openstreetmap/osm2pgsql.git &&\
    cd osm2pgsql &&\
    ./autogen.sh &&\
    ./configure &&\
    make &&\
    make install &&\
    cd /root &&\
    rm -rf src

ENTRYPOINT ["/bin/bash"]

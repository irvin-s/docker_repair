FROM debian:8.1
MAINTAINER Pit Kleyersburg <pitkley@googlemail.com>

ENV DEBIAN_FRONTEND noninteractive

ENV BUILD_PACKAGES gcc g++ make wget libpython2.7-dev libgsf-1-dev libboost-python-dev
ENV PACKAGES libgsf-1-114

ENV LIBPST_VERSION 0.6.66

RUN apt-get update && apt-get install -y --no-install-recommends $BUILD_PACKAGES $PACKAGES \
        && rm -rf /var/lib/apt/lists/* \
        && mkdir /tmp/libpst \
        && cd /tmp/libpst \
        && wget http://www.five-ten-sg.com/libpst/packages/libpst-$LIBPST_VERSION.tar.gz \
        && tar --strip-components=1 -xzf libpst-$LIBPST_VERSION.tar.gz \
        && ./configure \
        && make \
        && make install \
        && cd / \
        && rm -rf /tmp/libpst \
        && apt-get -y --force-yes purge $BUILD_PACKAGES \
        && apt-get -y --force-yes autoremove


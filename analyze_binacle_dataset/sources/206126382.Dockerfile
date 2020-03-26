# This file describes the standard way to build the dependencies for a CROPS
# dispatcher image
#
# Usage:
#
# # Build CODI dependencies image with the following command:
#
# docker build -t crops/codi:deps -f Dockerfile.codi.deps .
#

FROM debian:wheezy
MAINTAINER Todor Minchev <todor.minchev@linux.intel.com>

# Install dependencies
RUN apt-get update -qq && apt-get install -y -qq \
	libsqlite3-dev \
	libjansson-dev	\
	git	\
	wget \
	daemontools \
	autoconf  \
	automake  \
	libtool  \
	build-essential && \
	apt-get upgrade -y -qq

#Install a version of curl with unix sockets support
RUN cd /tmp && \
    git clone https://github.com/curl/curl.git curl && \
    cd curl && \
    git checkout tags/curl-7_45_0 && \
    ./buildconf && \
    ./configure --prefix=/usr --enable-unix-sockets && \
    make && \
    make install && \
    apt-get purge -y \
    	    autoconf \
	    automake \
	    libtool

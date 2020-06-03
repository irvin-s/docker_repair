#!/usr/bin/env docker

# Nginx/OpenResty (Sandbox)
#
# VERSION               0.0.1
#
# BUILD:
#   docker build -t openresty-nginx-base - < /vagrant/Dockerfile.base
#

FROM ubuntu:latest
MAINTAINER Jonas Grimfelt <grimen@gmail.com>

# NGINX/OPENRESTY DEPS
RUN apt-get install -q -y build-essential libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl wget curl git ufw mlocate vim nano imagemagick

## PCRE-JIT
WORKDIR /tmp/
RUN wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.33.tar.gz
RUN tar -xzvf pcre-8.33.tar.gz
WORKDIR /tmp/pcre-8.33
RUN ./configure --enable-jit
RUN make -j$(nproc)
RUN make install

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib
RUN ldconfig

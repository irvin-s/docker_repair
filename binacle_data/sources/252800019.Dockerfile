FROM debian:jessie  
  
MAINTAINER Vlad Dimitriu <vladimitriu@gmail.com>  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive \  
apt-get install -y build-essential wget less vim-nox zlib1g-dev && \  
mkdir /build && cd /build && \  
wget https://www.openssl.org/source/openssl-1.0.1s.tar.gz && \  
wget http://download.joedog.org/siege/siege-4.0.0.tar.gz && \  
tar zxvf openssl-1.0.1s.tar.gz && \  
tar zxvf siege-4.0.0.tar.gz && \  
cd /build/openssl-1.0.1s && \  
./config && make -j 8 && make install && \  
cd /build/siege-4.0.0 && \  
./configure \--prefix=/ \--with-ssl=/usr/local \--with-zlib=/usr && \  
make -j 8 && make install && \  
apt-get -f -y \--auto-remove remove build-essential wget && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /build  
  
RUN mkdir /siege  
WORKDIR /siege  
VOLUME /siege  


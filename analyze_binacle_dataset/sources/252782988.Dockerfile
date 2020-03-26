#Version: 0.0.1  
FROM node:0.12.7-slim  
MAINTAINER GPN DATA programmers "dd@gpndata.com"  
RUN apt-get update && \  
apt-get install -y \  
libtool \  
autoconf \  
automake \  
uuid-dev \  
build-essential \  
wget \  
pkg-config  
  
WORKDIR /zeromq  
  
RUN wget http://download.zeromq.org/zeromq-3.2.5.tar.gz && \  
tar zxvf zeromq-3.2.5.tar.gz > /dev/null  
  
WORKDIR /zeromq/zeromq-3.2.5  
  
RUN ./configure --without-libsodium && \  
make && \  
make install && \  
echo "include /usr/local/lib" >> /etc/ld.so.conf && \  
ldconfig


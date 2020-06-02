FROM ubuntu:xenial  
MAINTAINER Linfeng Liang <lianglinfeng@gmail.com>  
  
ENV HOME /build  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
autoconf automake autopoint \  
bison build-essential \  
ca-certificates cmake clang curl \  
git gperf gtk-doc-tools \  
libglib2.0-dev libffi-dev libpcre3-dev libmount-dev libssl-dev \  
openssh-client \  
pkg-config \  
texinfo \  
unzip \  
wget \  
zlib1g-dev  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
WORKDIR /build  


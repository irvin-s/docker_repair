FROM ubuntu:bionic  
  
MAINTAINER André Veríssimo <averissimo@gmail.com>  
  
# Necesary packages  
  
RUN apt-get update && \  
apt-get install -y \  
automake \  
autotools-dev \  
bsdmainutils \  
build-essential \  
curl \  
cmake \  
git \  
libboost-all-dev \  
libboost-all-dev \  
libevent-dev \  
libminiupnpc-dev \  
libprotobuf-dev \  
libqrencode-dev \  
libqt5core5a \  
libqt5dbus5 \  
libqt5gui5 \  
libssl-dev \  
libtool \  
pkg-config \  
protobuf-compiler \  
qttools5-dev \  
qttools5-dev-tools \  
wget \  
libseccomp-dev \  
libcap-dev && \  
rm -rf /var/lib/apt/lists/*  
  
# go to home directory  
  
RUN mkdir -p /coin/home  
  
VOLUME ["/coin/home"]  
  


FROM debian:jessie  
MAINTAINER Cliff Brake <cbrake@bec-systems.com>  
  
RUN \  
dpkg --add-architecture i386 && \  
apt-get update && \  
apt-get install -yq sudo build-essential git \  
python python3 man bash diffstat gawk chrpath wget cpio \  
texinfo lzop apt-utils bc screen libncurses5-dev locales \  
libc6-dev-i386 doxygen libssl-dev dos2unix \  
g++-multilib libssl-dev:i386 libcrypto++-dev:i386 zlib1g-dev:i386 && \  
rm -rf /var/lib/apt-lists/* && \  
echo "dash dash/sh boolean false" | debconf-set-selections && \  
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash  
  
RUN useradd -ms /bin/bash -p build build && \  
usermod -aG sudo build  
  
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \  
locale-gen  
  
ENV LANG en_US.utf8  
  
USER build  
WORKDIR /home/build  
  


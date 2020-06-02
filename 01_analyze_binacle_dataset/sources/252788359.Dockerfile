FROM ubuntu:14.04  
MAINTAINER Cristian Romo "cristian.g.romo@gmail.com"  
ENV DMD_VERSION 2.069.1  
ENV DMD_DEB dmd_$DMD_VERSION-0_amd64.deb  
  
RUN apt-get update && \  
apt-get install \  
gcc \  
libc6-dev \  
libcurl3 \  
wget \  
xdg-utils \  
-y && \  
rm -rf /var/lib/apt/lists/* && \  
wget http://downloads.dlang.org/releases/2.x/$DMD_VERSION/$DMD_DEB && \  
dpkg -i $DMD_DEB && \  
rm $DMD_DEB  
  
WORKDIR /source  
CMD ["bash"]


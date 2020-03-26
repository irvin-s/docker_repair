FROM ubuntu:latest  
MAINTAINER Daiki Aminaka <1991.daiki@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
build-essential \  
git \  
wget \  
pkg-config \  
python-pip \  
python-virtualenv \  
libhdf5-dev \  
libopencv-dev \  
libyaml-dev \  
&& rm -rf /var/lib/apt/lists/* \  
&& git clone https://github.com/NervanaSystems/neon /root/neon \  
&& make -C /root/neon sysinstall \  
&& rm -rf /root/neon/mkl*.tgz  
WORKDIR /root/neon  


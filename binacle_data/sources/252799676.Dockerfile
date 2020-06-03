# Base image for msbuild (uses Mono)  
FROM didstopia/msbuild  
  
# Maintainer info  
MAINTAINER Pauli Jokela <pauli.jokela@didstopia.com>  
  
# Update and install cross-platform build dependencies  
RUN apt-get update  
RUN apt-get install -y \  
gcc \  
g++ \  
gcc-multilib \  
g++-multilib \  
build-essential \  
xutils-dev \  
libsdl2-dev \  
libsdl2-gfx-dev \  
libsdl2-image-dev \  
libsdl2-mixer-dev \  
libsdl2-net-dev \  
libsdl2-ttf-dev \  
libreadline6-dev \  
libncurses5-dev \  
mingw-w64 \  
cmake  
  
# Install other dependencies  
RUN apt-get install -y python-pip git-core unzip zip curl bash  


FROM ubuntu:17.04  
MAINTAINER amaya <mail@sapphire.in.net>  
  
RUN deps='software-properties-common' && \  
apt-get update && \  
apt-get install -y --no-install-recommends $deps && \  
add-apt-repository ppa:ubuntu-toolchain-r/test && \  
apt-get update && \  
apt-get install -y gcc-7 g++-7 --no-install-recommends && \  
apt-get purge -y --auto-remove $deps && \  
rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*  
  
RUN ln -s $(which gcc-7) $(dirname $(which gcc-7))/gcc && \  
ln -s $(which g++-7) $(dirname $(which g++-7))/g++  
  
WORKDIR /app/  


FROM ubuntu:16.04  
MAINTAINER Daisuke Baba  
  
RUN ( \  
apt-get -qq update && \  
apt-get -qq install make git gcc-arm-none-eabi gyp ninja-build \  
)  
  
CMD bash  


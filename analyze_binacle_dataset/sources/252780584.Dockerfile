FROM ubuntu:trusty  
MAINTAINER Cooper Maa <coopermaa77@gmail.com>  
  
ENV IMG_VERSION 07-Feb-2015  
# Install dependencies for minimal linux live and qemu, git...  
# see http://minimal.linux-bg.org/  
RUN DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y \  
wget build-essential bc syslinux genisoimage busybox-static \  
libncurses5-dev git tree qemu  
  
RUN git clone https://github.com/ivandavidov/minimal/ && \  
cd minimal && \  
git checkout $IMG_VERSION  
  
ADD ./run /minimal/src/  
ADD ./fix-dns /minimal/src/  
WORKDIR /minimal/src  
RUN ./build_minimal_linux_live.sh  


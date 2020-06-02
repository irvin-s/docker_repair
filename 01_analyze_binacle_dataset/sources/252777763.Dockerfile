FROM ubuntu:16.04  
  
MAINTAINER AntSworD <zhengjj.asd@gmail.com>  
  
# Install necessary packages  
RUN apt-get update && \  
apt-get -y upgrade --fix-missing && \  
apt-get clean && \  
apt-get -y install \  
automake \  
autoconf \  
autoconf-archive \  
bzip2 \  
cmake \  
cvs \  
emacs24 \  
file \  
g++ \  
gcc \  
git \  
libtool \  
make \  
patch \  
subversion \  
tar \  
vim \  
wget \  
unzip \  
curl \  
xz-utils  


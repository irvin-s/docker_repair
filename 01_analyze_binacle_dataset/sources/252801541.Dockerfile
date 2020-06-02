FROM ubuntu:xenial  
  
# Get needed packages  
RUN set -x \  
&& buildDeps=' \  
ca-certificates \  
cmake \  
g++ \  
git \  
libboost-all-dev \  
libssl-dev \  
make \  
pkg-config \  
build-essential \  
libzmq3-dev \  
wget \  
' \  
&& apt-get -qq update \  
&& apt-get -qq install $buildDeps  
  
# Create app directory  
RUN mkdir -p /daemon && mkdir -p /daemon/data && mkdir -p /daemon  
  
# Install Daemon  
WORKDIR /daemon/  
RUN wget http://seeds.dero.io/alpha/dero_linux_amd64.tar.gz  
RUN tar -zxf dero_linux_amd64.tar.gz ./  
  
WORKDIR /daemon/  
  
EXPOSE 18081 18082


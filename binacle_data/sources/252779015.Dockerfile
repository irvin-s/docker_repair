FROM ubuntu:16.04  
  
RUN apt-get update && \  
apt-get install -y \  
libjansson-dev \  
gperf \  
cmake \  
clang \  
libfftw3-dev \  
wget \  
check \  
pkg-config \  
git  
  
RUN mkdir -p /root/.ssh  
COPY bitbucket_host_key /root/.ssh/known_hosts  


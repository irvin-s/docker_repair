FROM ubuntu:trusty  
  
MAINTAINER meh. <meh@1aim.com>  
  
# Add toolchains repository.  
RUN apt-get update -qq && \  
apt-get install -y software-properties-common python-software-properties && \  
add-apt-repository ppa:ubuntu-toolchain-r/test  
  
# Install needed packages.  
RUN apt-get update -qq && \  
apt-get install -y make openssh-client git g++-4.9  
  
# Clear huge aptitude cache.  
RUN rm -rf /var/lib/apt/lists/*  


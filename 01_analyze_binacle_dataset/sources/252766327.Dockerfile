FROM jesselang/debian-vagrant:jessie  
MAINTAINER Abigail <AbigailBuccaneer@users.noreply.github.com>  
  
RUN apt-get update -y && \  
apt-get install -y --no-install-recommends puppet lsb-release && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  


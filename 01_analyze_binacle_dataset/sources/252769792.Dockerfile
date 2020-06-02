FROM ubuntu:14.04  
MAINTAINER Arnaud Piroelle  
  
RUN apt-get update && apt-get upgrade -y  
  
RUN apt-get install -y \  
openssl \  
git \  
curl \  
unzip \  
wget \  
vim \  
python-software-properties \  
software-properties-common


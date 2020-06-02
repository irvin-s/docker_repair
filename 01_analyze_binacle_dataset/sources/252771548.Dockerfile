FROM ubuntu:16.04  
MAINTAINER Madhu Akula <madhu.akula@hotmail.com>  
  
RUN apt-get update && apt-get install -y curl \  
nmap htop  


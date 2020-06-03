FROM ubuntu:16.04  
MAINTAINER Amin Shah Gilani <amin@gilani.me>  
  
RUN mkdir /miner  
  
COPY build-miner.sh /miner  
  
RUN ["/bin/bash", "/miner/build-miner.sh"]  


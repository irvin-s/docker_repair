FROM ubuntu:14.04  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get install -y \  
curl dnsutils wget  
  


FROM centos:latest  
MAINTAINER Nathon Fowlie <nathon.fowlie@gmail.com>  
  
WORKDIR /tmp  
  
COPY install.sh install.sh  
  
RUN chmod a+x install.sh && \  
/bin/bash ./install.sh -v 8u131 -k d54c1d3a095b4ff2b6607d096fa80163  


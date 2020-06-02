FROM ubuntu:14.04  
MAINTAINER Democracy Works, Inc. <dev@democracy.works>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update # REFRESHED: 2015-01-09  
RUN apt-get upgrade -y -q  
  
RUN apt-get install -q -y wget ca-certificates software-properties-common \  
python-software-properties  


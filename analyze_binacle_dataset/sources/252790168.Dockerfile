FROM ubuntu:14.04  
MAINTAINER Caner Candan <caner@candan.fr>  
  
# Set correct environment variables  
ENV HOME /root  
ENV DEBIAN_FRONTEND noninteractive  
  
# update  
RUN apt-get -qq update  
  
# install python3 + pip3  
RUN apt-get -qqy install python3 python3-pip  
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10  
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10  


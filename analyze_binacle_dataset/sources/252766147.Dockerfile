FROM ubuntu:latest  
LABEL MAINTAINER="Aaron Trout <aaron@trouter.co.uk>"  
  
RUN apt-get update && apt-get install -y python python-dev python-pip \  
libxft-dev libfreetype6 libfreetype6-dev  
  
RUN pip install matplotlib  


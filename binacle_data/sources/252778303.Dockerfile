FROM ubuntu:14.04  
MAINTAINER "Abdul Gaffur A Dama"  
RUN sed -i 's/archive.ubuntu.com/kambing.ui.ac.id/g' \  
/etc/apt/sources.list  
  
RUN apt-get update  
  
RUN apt-get install -y build-essential


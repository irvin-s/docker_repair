FROM ubuntu:xenial  
  
MAINTAINER Alex Leith  
  
RUN apt-get update && apt-get install -y software-properties-common  
  
RUN apt-add-repository ppa:duplicity-team/ppa  
RUN apt-get update && apt-get install -y duplicity python-boto  


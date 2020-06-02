FROM ubuntu:xenial  
RUN apt-get -y update  
RUN apt-get -y upgrade  
RUN apt-get -y install tree openssh-server vim  
RUN apt-get -y autoclean  
RUN apt-get -y autoremove  
COPY ./Sources.list /etc/apt/sources.list  


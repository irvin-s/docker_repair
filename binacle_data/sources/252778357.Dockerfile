FROM ubuntu:16.04  
MAINTAINER Andrzej Raczkowski <andrzej.raczkowski@sviete.pl>  
  
EXPOSE 6680  
# all installation files  
COPY scripts /scripts  
  
# start the installation  
RUN /scripts/install_main.sh  


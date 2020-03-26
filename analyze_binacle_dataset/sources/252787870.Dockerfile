FROM ubuntu:latest  
ARG DEBIAN_FRONTEND=noninteractive  
RUN apt-get update  
RUN apt-get -qq install software-properties-common  
RUN add-apt-repository ppa:git-ftp/ppa  
RUN apt-get update  
RUN apt-get -qq install git git-ftp  


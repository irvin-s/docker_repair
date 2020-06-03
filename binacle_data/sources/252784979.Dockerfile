FROM node:4.2.4  
MAINTAINER Lancelot Prigent <lancelot.prigent@gmail.com>  
  
ENV LANGUAGE node  
ENV LANGUAGE_VERSION 4.2.4  
RUN apt-get update  
RUN apt-get install -y rsync  


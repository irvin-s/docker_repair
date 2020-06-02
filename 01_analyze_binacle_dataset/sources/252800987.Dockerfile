FROM node:latest  
  
MAINTAINER dpolyakov "docker@dimapolyakov.ru"  
RUN apt-get update && \  
apt-get -y install rsync  


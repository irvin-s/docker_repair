FROM ubuntu:14.04.3  
  
MAINTAINER serge.dmitriev@gmail.com  
  
RUN apt-get update && \  
apt-get install -y build-essential libssl-dev nodejs npm && \  
apt-get clean  
  
RUN npm install -g voicer


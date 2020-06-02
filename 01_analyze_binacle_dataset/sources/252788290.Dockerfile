# DOCKER-VERSION 0.3.4  
FROM ubuntu:12.04  
MAINTAINER Christoffer Niska, ChristofferNiska@gmail.com  
  
RUN apt-get update  
  
RUN apt-get install -y python-software-properties python g++ make  
RUN add-apt-repository ppa:chris-lea/node.js  
RUN apt-get update  
RUN apt-get install -y nodejs  
RUN npm install -g grunt-cli  
  
ADD . /src  
RUN cd /src; npm install  
  
EXPOSE 8080


FROM node:8  
MAINTAINER Marcos Sánchez <arkanus@gmail.com>  
  
RUN apt-get update -y &&\  
apt-get install -y unzip zip opus-tools  
  
COPY . /quakejs  
WORKDIR /quakejs  
RUN npm install  


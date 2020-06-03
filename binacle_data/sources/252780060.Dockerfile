FROM ubuntu:14.04  
MAINTAINER ContainerShip Developers <developers@containership.io>  
  
RUN mkdir /app  
WORKDIR /app  
RUN apt-get update && apt-get install -y curl git npm  
RUN npm install n -g  
ADD . /app  
RUN n 0.10.38  
RUN npm install  
CMD node application  


FROM node:6.9.1  
MAINTAINER Adrien Remacle <adrien@buildog.com>  
  
# create a layer for dependencies so they're cached  
RUN mkdir -p /reactjs  
WORKDIR /reactjs  
COPY package.json package.json  
RUN npm install  
RUN npm install -g concurrently  
  
# copy the source and build  
COPY . /reactjs  


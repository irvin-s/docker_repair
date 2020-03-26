FROM node:6.3.0  
MAINTAINER Joao Cunha <joao.cunha@advertilemobile.com>  
  
WORKDIR /usr/src/app  
  
COPY package.json npm-shrinkwrap.json /usr/src/app/  
RUN npm install  


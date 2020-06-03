FROM node:alpine  
MAINTAINER Cristian Romo "cristian.g.romo@gmail.com"  
RUN npm install -g LiveScript  
RUN mkdir /source  
WORKDIR /source  
CMD ["lsc"]  


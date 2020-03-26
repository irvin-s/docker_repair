FROM node:onbuild  
MAINTAINER Rémi AUGUSTE <remi.auguste@gmail.com>  
  
ADD ./data /data  
ADD ./server.js /usr/src/app  
ADD ./package.json /usr/src/app  
RUN rm -rf /usr/src/app/data  
RUN ln -s /data /usr/src/app  
  
EXPOSE 8080


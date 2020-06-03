FROM node:8-alpine  
  
RUN apk add \--no-cache --virtual .build-deps-zeromq \  
zeromq \  
zeromq-dev  


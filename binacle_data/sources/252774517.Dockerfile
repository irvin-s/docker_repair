FROM mhart/alpine-node:latest  
MAINTAINER Ashley Murphy <irashp@gmail.com>  
  
RUN apk add --no-cache git && \  
npm install -g vue-cli  


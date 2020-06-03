FROM node:8.1.2-alpine  
  
MAINTAINER cogso <https://github.com/cogso/alpine-nodejs-builder>  
  
# Install dependencies  
RUN apk add --quiet --no-cache bash git && \  
yarn global add gulp gulp-cli && \  
rm -rf /var/cache/* /tmp/*  
  
RUN mkdir /app  
  
# Define working directory.  
# VOLUME ["/app"]  
WORKDIR /app  


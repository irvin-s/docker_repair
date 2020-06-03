FROM node:4.2.4  
  
MAINTAINER Lancelot Prigent <lancelot.prigent@gmail.com>  
  
RUN npm install -g strongloop && rm -rf npm_cache /tmp/*  
ENV NODE_PATH /usr/local/lib/node_modules/  


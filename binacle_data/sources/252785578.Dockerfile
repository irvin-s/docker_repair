FROM node:8  
MAINTAINER Hyeseong Kim <cometkim.kr@gmail.com>  
  
RUN mkdir -p /tmp/docs  
WORKDIR /tmp  
  
RUN npm install flybook  
  
ONBUILD COPY package.json .  
ONBUILD COPY docs ./docs  
  
ONBUILD RUN npx flybook docs --outdir=/out --prod  


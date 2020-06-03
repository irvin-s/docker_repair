FROM node:7-alpine  
  
RUN apk add --no-cache \  
ca-certificates \  
git \  
openssh \  
&& npm install -g yarn  


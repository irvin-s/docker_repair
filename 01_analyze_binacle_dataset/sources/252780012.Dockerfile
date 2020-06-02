FROM node:6  
MAINTAINER xun "me@xun.my"  
RUN mkdir -p /opt/npm-register  
WORKDIR /opt/npm-register  
  
ENV NODE_ENV production  
  
# make sure the package.json cache is fully utilized  
COPY package.json /opt/npm-register  
RUN npm install --quiet  
  
RUN npm cache clean  
  
COPY . /opt/npm-register  
  
ENTRYPOINT ["/usr/local/bin/node", "server.js"]  
  
# docker build -t axnux/npm-register:latest . #  


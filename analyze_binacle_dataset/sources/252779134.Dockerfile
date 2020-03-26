FROM node:5  
MAINTAINER Octoblu, Inc. <docker@octoblu.com>  
  
EXPOSE 80  
HEALTHCHECK CMD curl --fail http://localhost:80/healthcheck || exit 1  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm -s install --production  
COPY . /usr/src/app/  
  
CMD [ "node", "server.js" ]  


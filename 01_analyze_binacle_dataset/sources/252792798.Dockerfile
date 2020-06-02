FROM node:6.11-alpine  
  
RUN npm install -g gulp  
RUN npm install -g bower  
RUN npm install -g grunt-cli  
RUN apk add --update git python make g++  
  
RUN mkdir -p /var/www  
VOLUME ["/var/www"]  
  
WORKDIR /var/www  
  


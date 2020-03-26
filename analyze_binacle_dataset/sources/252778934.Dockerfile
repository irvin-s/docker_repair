FROM node:5.7.0  
RUN mkdir -p /var/www  
WORKDIR /var/www  
COPY . /var/www  
RUN npm shrinkwrap  
RUN npm install  
ENTRYPOINT node server.js  


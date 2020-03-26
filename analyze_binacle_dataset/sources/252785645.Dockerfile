FROM node:latest  
  
MAINTAINER thomasdolar@gmail.com  
  
ENV NODE_ENV=production  
  
COPY . /var/www/socket  
  
RUN npm install supervisor -g  
  
WORKDIR /var/www/socket  
  
RUN npm install  
  
EXPOSE 8443  
ENTRYPOINT ["supervisor", "socket.js"]


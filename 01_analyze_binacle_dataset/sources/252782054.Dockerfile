FROM node:wheezy  
MAINTAINER github.com/ChurroLoco  
RUN npm install http-server -g && mkdir -p /var/www  
CMD ["http-server", "/var/www"]  
EXPOSE 8080  


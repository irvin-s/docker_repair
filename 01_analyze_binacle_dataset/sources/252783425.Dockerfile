  
############################################################  
# Dockerfile to build prestashop apache-php container images  
# Based on phusion/baseimage  
############################################################  
# Set the base image to node:alpine - stripped down version of node  
  
FROM node:alpine  
  
# File Author / Maintainer  
MAINTAINER Jonathan Temlett - Daedalus Solutions (jono@daedalus.co.za)  
  
RUN mkdir /var/www  
RUN mkdir /var/www/site  
RUN mkdir /var/www/site/public  
  
  
ADD app.js /var/www/site/  
ADD package.json /var/www/site/  
COPY public /var/www/site/public/  
#COPY app /var/www/site/app/  
  
WORKDIR /var/www/site/  
  
RUN npm install  
  
EXPOSE 80  
  
CMD npm start


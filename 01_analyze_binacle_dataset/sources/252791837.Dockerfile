FROM node:latest  
MAINTAINER dan budris <dbudris@bu.edu>  
  
RUN apt-get update -y  
RUN apt-get install -y \  
vim \  
wget \  
git  
  
WORKDIR /srv  
RUN git clone https://github.com/danbudris/governetworks.git  
  
WORKDIR /srv/governetworks/v2  
RUN npm install  
  
EXPOSE 8080  
CMD node serve.js  


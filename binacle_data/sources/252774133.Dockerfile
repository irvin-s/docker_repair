FROM node:latest  
MAINTAINER Amarin Boonkirt <amarin@rvglobalsoft.com>  
  
RUN npm install -g bower grunt-cli gulp  
RUN npm install -g cross-env  
  
COPY package.json /tmp/  
RUN cd /tmp/  
RUN npm install  
  
VOLUME /usr/local/lib/laravel_node_modules  


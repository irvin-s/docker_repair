FROM node:8.11.1  
MAINTAINER Automation Team  
  
RUN npm install grunt --save-dev  
ENV PATH="/node_modules/grunt/bin/:${PATH}"  


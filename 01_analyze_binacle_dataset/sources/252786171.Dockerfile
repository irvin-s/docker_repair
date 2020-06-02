FROM node:8-alpine  
  
MAINTAINER Dmytro Studynskyi <dimitrystd@gmail.com>  
  
COPY . /opt/app  
WORKDIR /opt/app  
RUN npm install  
  
ENV AWS_ACCESS_KEY_ID="key is required"  
ENV AWS_SECRET_ACCESS_KEY="secret is required"  
VOLUME /opt/app/cache  
EXPOSE 3000  
CMD node server.js  


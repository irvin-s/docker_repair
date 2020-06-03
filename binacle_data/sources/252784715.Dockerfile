FROM node:argon  
MAINTAINER Adrian Perez <adrian@adrianperez.org>  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install  
  
COPY . /usr/src/app  
VOLUME /usr/src/app/parse/cloud  
  
EXPOSE 8080  
CMD [ "npm", "start" ]  


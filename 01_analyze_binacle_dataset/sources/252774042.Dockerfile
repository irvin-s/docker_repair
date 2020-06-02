FROM node:5.11  
MAINTAINER Alexandru Rosianu <me@aluxian.com  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY . /usr/src/app/  
RUN npm install  
  
CMD [ "npm", "start" ]  
  
EXPOSE 3000  


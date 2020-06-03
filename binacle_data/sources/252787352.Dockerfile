FROM node:6.4.0  
MAINTAINER Bridgeme <yoda.mentor.lab@gmail.com>  
  
RUN mkdir -p /app  
WORKDIR /app  
  
COPY package.json /app  
  
RUN npm install  
  
COPY . /app  
  
EXPOSE 5000  
CMD [ "npm", "start" ]  


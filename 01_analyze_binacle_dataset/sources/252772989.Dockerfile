FROM node:4.1  
MAINTAINER phyxkal <haikalvidya@gmail.com>  
  
RUN mkdir -p /usr/src/webapp  
  
WORKDIR /usr/src/webapp  
COPY package.json ./  
RUN npm install  
  
COPY . /usr/src/webapp  
  
ENV NODE_ENV=production  
ENV DB_URI=mongodb://mongo/strider  
EXPOSE 3000  
CMD [ "npm", "start" ]  


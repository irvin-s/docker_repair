FROM node:4.4.3  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install  
  
VOLUME ["/usr/src/app"]  
  
CMD [ "npm", "start" ]  


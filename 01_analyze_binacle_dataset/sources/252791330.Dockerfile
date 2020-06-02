FROM node:boron  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install  
  
COPY . /usr/src/app  
  
EXPOSE 5000 8001  
CMD [ "npm", "start" ]  


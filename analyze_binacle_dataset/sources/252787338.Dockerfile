FROM node:5.5.0  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
ONBUILD COPY . /usr/src/app/  
ONBUILD RUN npm install  
  
CMD [ "npm", "start" ]  


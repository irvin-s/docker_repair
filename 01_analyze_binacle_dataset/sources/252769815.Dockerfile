FROM node:carbon  
  
RUN mkdir -p /src/app  
WORKDIR /src/app  
  
COPY package*.json /src/app/  
COPY . /src/app  
RUN npm install --unsafe-perm  
  
EXPOSE 8080  
EXPOSE 8443  
CMD [ "npm", "start" ]  


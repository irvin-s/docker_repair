# FROM mhart/alpine-node:latest  
FROM airburst/docker-node-oracle:latest  
  
# Create app directory  
RUN mkdir -p /usr/app  
WORKDIR /usr/app  
  
# Install app dependencies  
COPY package.json /usr/app/  
  
# RUN npm install  
RUN npm install  
  
# Bundle app source  
COPY . /usr/app  
  
# Build production (dist) folder  
RUN npm run build  
  
# Make logfiles available outside container  
VOLUME ["/usr/app/logs"]  
  
EXPOSE 7001  
# Serve dist folder  
CMD [ "node", "dist/index.js" ]  


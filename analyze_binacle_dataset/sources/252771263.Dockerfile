FROM mhart/alpine-node:latest  
  
# Create app directory  
RUN mkdir -p /usr/app  
RUN mkdir -p /usr/app/logs  
WORKDIR /usr/app  
  
# Install app dependencies  
COPY package.json /usr/app/  
  
# RUN npm install and make production build  
RUN npm install  
  
# Bundle app source  
COPY . /usr/app  
  
# Build production (dist) folder  
RUN npm run build  
  
# Make logfiles available outside container  
VOLUME ["/usr/app/logs", "/usr/app/files"]  
  
EXPOSE 3001  
# Serve dist folder  
CMD [ "node", "dist/index.js" ]  


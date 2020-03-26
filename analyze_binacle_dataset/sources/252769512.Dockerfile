# Node.js version  
FROM node:4.3.2  
# install updated NPM && install nodemon  
RUN npm install --global npm@3.7.5 && npm install -g nodemon  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# get the npm modules that need to be installed  
COPY package.json /usr/src/app/  
WORKDIR /usr/src/app  
  
# install npm modules  
RUN npm install  
  
# copy the source files from host to container  
COPY . /usr/src/app


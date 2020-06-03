FROM node  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
RUN apt-get update -y && \  
apt-get upgrade -y && \  
apt-get install -y build-essential  
  
# Use specifically node v6.0.0 using N (to ensure node-gyp compilation)  
# We don't use a node:6 container because  
# it would take too long to perform "apt-get upgrade"  
RUN npm install -g n  
RUN n 6.0.0  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
  
CMD [ "npm", "start" ]


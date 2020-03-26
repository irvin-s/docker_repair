FROM node:7.6-slim  
  
MAINTAINER Miguel Asencio <maasencioh@gmail.com>  
  
# Create app directory  
WORKDIR /git/user-crud  
  
# Install app dependencies  
COPY package.json /git/user-crud/  
RUN npm install --production  
  
# Bundle app source  
COPY . /git/user-crud/  
  
CMD [ "npm", "start" ]


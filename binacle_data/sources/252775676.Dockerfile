FROM node:7.6-slim  
  
MAINTAINER Miguel Asencio <maasencioh@gmail.com>  
  
# Create app directory  
WORKDIR /git/auth  
  
# Install app dependencies  
COPY package.json /git/auth/  
RUN npm install --production  
  
# Bundle app source  
COPY . /git/auth/  
  
CMD [ "npm", "start" ]


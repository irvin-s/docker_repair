FROM node:7.6-slim  
  
MAINTAINER Miguel Asencio <maasencioh@gmail.com>  
  
# Create app directory  
WORKDIR /git/api-gateway  
  
# Install app dependencies  
COPY package.json /git/api-gateway/  
RUN npm install --production  
  
# Bundle app source  
COPY . /git/api-gateway/  
  
CMD [ "npm", "start" ]


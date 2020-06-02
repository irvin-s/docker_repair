FROM node:6-slim  
  
MAINTAINER Miguel Asencio <maasencioh@gmail.com>  
  
# Create app directory  
WORKDIR /git/periodic-bot  
  
# Install app dependencies  
COPY package.json /git/periodic-bot/  
RUN npm install --production  
  
# Bundle app source  
COPY ["*.js", "*.json", "/git/periodic-bot/"]  
  
CMD [ "npm", "start" ]  


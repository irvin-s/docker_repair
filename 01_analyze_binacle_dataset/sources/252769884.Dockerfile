FROM node:carbon-slim  
  
# Create app directory  
WORKDIR /git/matches-ms  
  
# Install app dependencies  
COPY package.json /git/matches-ms/  
RUN npm install --production  
  
# Bundle app source  
COPY . /git/matches-ms/  
  
EXPOSE 4003  


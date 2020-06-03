# Source container  
FROM node:8.1.2-alpine  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install dependencies  
copy package.json /usr/src/app  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
  
# Accessible from 3000 (default port on Express.js)  
EXPOSE 3000  
# Start  
CMD [ "npm", "start" ]


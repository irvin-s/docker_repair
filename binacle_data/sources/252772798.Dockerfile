FROM node:alpine  
WORKDIR /var/poller  
COPY /src/package*.json ./  
RUN npm install --production  
COPY /src/. ./  
CMD [ "npm", "start" ]


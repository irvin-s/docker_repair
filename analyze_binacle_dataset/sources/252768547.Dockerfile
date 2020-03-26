FROM node:argon  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY node_app/package.json /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY node_app/server.js /usr/src/app/  
  
EXPOSE 8080  
CMD [ "npm", "start" ]


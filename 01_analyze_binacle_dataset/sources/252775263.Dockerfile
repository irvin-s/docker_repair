FROM node:carbon-slim  
  
# Create app directory  
WORKDIR /git/gateway-api  
  
# Install app dependencies  
COPY package.json /git/gateway-api/  
RUN npm install  
  
# Bundle app source  
COPY . /git/gateway-api/  
RUN npm run prepublish  
  
CMD [ "npm", "run", "runServer" ]  
  
EXPOSE 5000  


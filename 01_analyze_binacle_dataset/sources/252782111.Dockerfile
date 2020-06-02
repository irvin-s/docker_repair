FROM node:8  
RUN apt-get update -qq && apt-get install -y libjansson-dev  
COPY package.json ./  
COPY . ./  
RUN npm install && npm test  


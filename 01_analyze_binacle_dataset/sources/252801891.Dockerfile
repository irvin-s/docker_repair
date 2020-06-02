FROM node:9.2.0  
  
# Install app dependencies  
RUN apt-get update && apt-get upgrade -y  
RUN apt-get install git -y  
RUN npm install --save-dev cross-env  
RUN npm install -g nuxt-cli  
RUN npm install -g pm2  


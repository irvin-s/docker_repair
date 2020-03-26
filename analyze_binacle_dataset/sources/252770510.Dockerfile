FROM node  
  
# express-runner  
WORKDIR /data/express-runner  
COPY package.json .  
RUN npm install  
COPY ./ ./  
  
# the app  
WORKDIR /data/app  


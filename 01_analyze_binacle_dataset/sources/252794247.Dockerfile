FROM mhart/alpine-node:latest  
  
WORKDIR /src  
ADD package.json .  
RUN npm install  
  
ADD . .  


FROM node:latest  
  
MAINTAINER Ben Ben Sasson  
  
ADD package.json package.json  
RUN npm install  
  
ADD . .  
RUN npm run build -- --release  
  
EXPOSE 8889  
CMD node build/server.js  


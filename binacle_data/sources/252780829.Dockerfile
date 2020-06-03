FROM node:9-alpine  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
ARG NODE_ENV=production  
  
COPY ./ /usr/src/  
RUN npm install && npm cache clean --force  
  
CMD [ "npm", "start" ]  


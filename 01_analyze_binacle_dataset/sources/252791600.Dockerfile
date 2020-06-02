FROM node:alpine  
WORKDIR /prime  
  
ADD package.json package-lock.json /prime/  
  
RUN npm install --production --silent  
  
EXPOSE 3000  
ADD . /prime  
CMD node keystone.js  


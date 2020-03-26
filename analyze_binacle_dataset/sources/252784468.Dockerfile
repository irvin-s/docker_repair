FROM node:8  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json yarn.lock /usr/src/app/  
RUN yarn && yarn cache clean  
COPY . /usr/src/app  
  
CMD [ "node", "authApp.js" ]  


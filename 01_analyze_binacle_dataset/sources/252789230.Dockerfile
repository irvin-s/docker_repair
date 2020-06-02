FROM node:8.0.0  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN yarn && yarn cache clean  
COPY . /usr/src/app  
  
CMD [ "npm", "start" ]  


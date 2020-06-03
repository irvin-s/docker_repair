FROM node:boron-alpine  
LABEL Name=cling Version=1.0.0-alpha.0  
  
RUN yarn global add pm2 && yarn cache clean  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
ADD package.json /usr/src/app/package.json  
RUN yarn install && yarn cache clean  
COPY . /usr/src/app  
RUN yarn build  
  
CMD ["pm2-docker", "/usr/src/app/dist/index.js"]  


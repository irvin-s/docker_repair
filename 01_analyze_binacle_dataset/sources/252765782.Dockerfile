FROM node:8.9.4  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN yarn install && yarn cache clean --force  
  
COPY . /usr/src/app  
  
RUN yarn run build && mv /usr/src/app/dist /files  


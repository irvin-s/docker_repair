FROM node:10.15.3-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . . 

CMD ['node', 'greatBay.js']
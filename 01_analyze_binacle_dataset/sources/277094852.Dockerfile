FROM node:latest

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package.json /usr/src/app

RUN npm i && npm i -g nodemon && npm i -g truffle
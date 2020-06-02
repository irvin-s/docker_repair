FROM node:alpine

WORKDIR /usr/src/server
COPY package.json .

RUN npm install

COPY . .
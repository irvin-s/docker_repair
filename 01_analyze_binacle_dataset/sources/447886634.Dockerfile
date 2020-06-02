FROM node:8.9.4-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

VOLUME /usr/src/app

RUN npm install -g webpack
RUN npm install -g webpack-dev-server
RUN yarn install

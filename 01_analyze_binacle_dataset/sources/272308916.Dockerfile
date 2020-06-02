FROM node:8.9-slim

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV NODE_ENV development


RUN npm i -g nodemon

EXPOSE 80

CMD nodemon --watch ./packages/server -e html,js,json packages/server/index.js

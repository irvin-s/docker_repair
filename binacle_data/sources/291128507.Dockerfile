FROM node:10.8-alpine

WORKDIR /app
ADD ./package-lock.json .
ADD ./package.json .
RUN npm install

ADD ./public public
ADD ./src src
ADD ./test test
ADD ./server.js .
CMD npm start


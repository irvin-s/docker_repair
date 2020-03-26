FROM node:8.9.1-alpine

RUN apk add --no-cache git make gcc g++ python

RUN mkdir /src

ENV PATH "$PATH:/src/node_modules/.bin"

ONBUILD ADD package.json /src/package.json
ONBUILD RUN cd /src; npm install

ONBUILD WORKDIR /src/server

ONBUILD CMD npm start

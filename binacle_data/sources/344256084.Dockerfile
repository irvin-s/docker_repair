FROM node:10-alpine

RUN npm install -g npm@6 && rm -rf ~app/.npm /tmp/*

RUN apk add --no-cache make git gcc g++ python

RUN addgroup -g 10001 app && \
    adduser -D -G app -h /app -u 10001 app
WORKDIR /app

USER app

COPY npm-shrinkwrap.json npm-shrinkwrap.json
COPY package.json package.json

RUN npm ci --production && rm -rf ~app/.npm /tmp/*

COPY . /app

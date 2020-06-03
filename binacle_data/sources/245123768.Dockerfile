FROM node:7.1-alpine

RUN apk add --no-cache bash python=2.7.12-r0 make gcc g++

RUN npm install -g angular-cli


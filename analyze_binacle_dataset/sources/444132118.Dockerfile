FROM node:6.11-alpine

EXPOSE 3001
RUN apk update && apk add --no-cache bash

WORKDIR /app

COPY ./wait-for-it.sh .

COPY ./package.json .
RUN yarn install --production=false

COPY ./ ./
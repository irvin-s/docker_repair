FROM node:7.7.2-alpine

RUN apk add --no-cache build-base

## cache node_modules
ADD ./package.json /tmp/package.json
RUN cd /tmp && NODE_ENV=production npm install
RUN mkdir -p /app/src && cp -a /tmp/node_modules /app/

## copy meta
WORKDIR /app
ADD ./package.json /app/package.json

## build
WORKDIR /app
ADD ./static /app/static
ADD \.next/ /app/.next
ADD ./server /app/server
ADD ./entry.js /app/entry.js
ADD ./category.js /app/category.js
ADD ./docs /app/docs
ADD ./CHANGELOG.md /app/CHANGELOG.md
## Clean and lean
RUN npm i -g modclean && modclean -r -D ./node_modules && npm r -g modclean

## Copy seed
WORKDIR /app/seed
ADD ./seed/json /app/seed/json
ADD ./seed/json /json

## RETURN TO /app
WORKDIR /app

EXPOSE 3000
CMD ["npm", "start"]

FROM node:9.9-alpine

WORKDIR /src/app/

ADD ./package.json .

RUN ["npm", "install"]

COPY . .

RUN chown -R node:node /src/app

USER node

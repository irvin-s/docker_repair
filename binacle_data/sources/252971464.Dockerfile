ARG NODE_VERSION=8-alpine

FROM node:${NODE_VERSION}
ARG ENVIRONMENT=prod
ENV ENV=${ENVIRONMENT}

ENV node_env=development


WORKDIR /usr/src/app
COPY package.json package-lock.json ./

RUN npm install

COPY . .
RUN npm run "build:${ENV}"


FROM node:10

WORKDIR /

COPY . /cryptoverse

WORKDIR /cryptoverse

RUN yarn install --pure-lockfile

RUN yarn build

WORKDIR /

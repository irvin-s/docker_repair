FROM node:9

WORKDIR /

COPY . /cryptopurr

WORKDIR /cryptopurr

RUN yarn install --pure-lockfile

WORKDIR /

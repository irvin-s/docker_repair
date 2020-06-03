FROM node:8.5.0

WORKDIR /

COPY package.json .
COPY yarn.lock .
RUN yarn

WORKDIR /mnt

FROM node:8.5.0

WORKDIR /

COPY package.json .
RUN yarn

WORKDIR /mnt
COPY . .

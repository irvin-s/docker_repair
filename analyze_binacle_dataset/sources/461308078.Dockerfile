FROM node:boron

WORKDIR /usr/app

COPY package.json .

RUN npm install --quiet

COPY . .
RUN npm run setup


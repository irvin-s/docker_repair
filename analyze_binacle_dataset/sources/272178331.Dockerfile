FROM node:boron

WORKDIR /usr/src/app

COPY . .

ENV NPM_CONFIG_LOGLEVEL warn

RUN npm install

RUN npm run build

EXPOSE 3000
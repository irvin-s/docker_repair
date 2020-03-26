FROM node:8

WORKDIR /usr/src/app

ADD yarn.lock /usr/src/app/yarn.lock
ADD package.json /usr/src/app/package.json
RUN yarn install

COPY . /usr/src/app

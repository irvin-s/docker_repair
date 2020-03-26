FROM node:latest

RUN mkdir -p /usr/src/app
RUN mkdir -p /logs

WORKDIR /usr/src/app

COPY package.json /usr/src/app

RUN npm install  

COPY . /usr/src/app

CMD npm start

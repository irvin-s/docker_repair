FROM node:0.10.28
MAINTAINER Travis Thieman <travis@gc.io>

ADD . /usr/src/lox
WORKDIR /usr/src/lox

RUN npm install

EXPOSE 80

CMD node lox.js

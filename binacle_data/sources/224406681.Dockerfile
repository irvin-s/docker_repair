FROM node:6.1
MAINTAINER Nathan Lopez <nathan.lopez042@gmail.com>

WORKDIR /opt/soft
ADD . .

RUN npm install --prefix vendor

RUN npm install -g typescript

RUN npm install -g ts-node
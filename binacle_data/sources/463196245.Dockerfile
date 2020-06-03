FROM node:8

RUN npm install -g webpack-dev-server

WORKDIR /srv/app

ADD ./ /srv/app/

FROM ubuntu:15.04
FROM node:latest

COPY . /app
WORKDIR /app

RUN npm install -g bower
RUN npm install
RUN bower --allow-root install
RUN npm install forever -g

EXPOSE 8080
EXPOSE 1025

ENTRYPOINT forever server.js
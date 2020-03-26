FROM node:8

RUN mkdir -p /usr/src
WORKDIR /usr/src/
COPY . /usr/src/

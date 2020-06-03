FROM node:8

ENV NODE_ENV development

ADD . /app
WORKDIR /app

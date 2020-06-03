FROM node:slim

MAINTAINER Eric Biven <eric@biven.us>

RUN npm install --quiet --global \
      @vue/cli

RUN mkdir /code
COPY . /code

WORKDIR /code

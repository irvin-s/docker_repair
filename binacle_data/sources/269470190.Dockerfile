FROM node:0.12

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libkrb5-dev

RUN ls /app

#RUN mkdir /app
WORKDIR /app/test

#ADD package.json /app/package.json

RUN npm install
#ADD . /app
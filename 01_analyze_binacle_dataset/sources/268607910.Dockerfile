FROM node:6.11.1

RUN apt-get update -qq && apt-get install -y netcat

ENV APP_HOME /express
WORKDIR $APP_HOME

COPY app.js $APP_HOME
COPY package.json $APP_HOME
COPY start $APP_HOME

RUN npm install

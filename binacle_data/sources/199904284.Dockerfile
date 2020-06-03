FROM mhart/alpine-node:4

ADD . /app
WORKDIR /app

RUN npm install

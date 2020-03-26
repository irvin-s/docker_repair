FROM mhart/alpine-node:5

RUN mkdir -p /app
WORKDIR /app

ADD ./package.json .
RUN npm install -g mocha
RUN npm install

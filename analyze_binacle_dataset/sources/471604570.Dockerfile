FROM node:10.13-alpine

COPY . /app/

WORKDIR /app/server

RUN sh /app/docker/development/docker-build.sh

CMD npm start -- --startProxy

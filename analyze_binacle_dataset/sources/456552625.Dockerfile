FROM mhart/alpine-node:8

WORKDIR /app
COPY ./core/ /app/core
COPY ./database/ /app/database
COPY ./web/ /app/web
COPY ./package.json /app/
COPY ./jest.config.js /app/

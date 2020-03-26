# app &  storybook & docs
FROM node:alpine as dev-stage
WORKDIR /app

# mock server
FROM node:alpine as mock-server
RUN npm install -g nodemon
WORKDIR /data
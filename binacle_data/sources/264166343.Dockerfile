# FROM node:8.1.1
# See https://github.com/nodejs/node/issues/13667
# RUN npm config set dist-url https://nodejs.org/download/release/  --global

FROM node:7.1.0

RUN apt-get update
RUN apt-get install -y libudev-dev

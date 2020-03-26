FROM node:9.11-alpine

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN script/docker/setup

ENV NODE_ENV=production

CMD [ "yarn", "start" ]

FROM node:latest

ARG APP_PATH=/hackbot

COPY package.json $APP_PATH/package.json

WORKDIR $APP_PATH

RUN npm install

COPY . $APP_PATH

ENTRYPOINT ["./bin/hubot", "-a", "slack"]

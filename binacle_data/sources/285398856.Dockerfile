FROM node:alpine

LABEL maintainer="arne@hilmann.de"

RUN npm install -g live-server && npm cache clean --force

EXPOSE 8080

VOLUME /target
WORKDIR /target

ENTRYPOINT node /usr/local/bin/live-server --no-browser --wait=100 --watch=/target/index.html,assets/css/ .

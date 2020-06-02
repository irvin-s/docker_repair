FROM mhart/alpine-node:4

RUN mkdir app

RUN adduser node -D
RUN chown node:node app
WORKDIR app
USER node

ADD lib/ lib/
ADD test/ test/
ADD theme/ theme/
ADD templates/ templates/
ADD README.md README.md

USER root

ADD package.json package.json
RUN npm install

USER node

ENTRYPOINT node /lib/cli.js

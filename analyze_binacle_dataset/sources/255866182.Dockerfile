FROM mhart/alpine-node:latest

LABEL maintainer="Kyle Polich"

RUN apk add --no-cache nodejs-current tini

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

COPY package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /usr/src/app && cp -a /tmp/node_modules /usr/src/app/

RUN npm install --save-dev -g babel-cli
RUN npm i -g npm@5.6.0

WORKDIR /usr/src/app

## Copy app sources
COPY . /usr/src/app
RUN rm -rf /usr/src/app/.env

RUN ./bin/info.sh

RUN npm run-script build

## Expose used ports
EXPOSE 80 443 4430 3000 9001

## Run
CMD ["/bin/sh", "-c", "/usr/src/app/startup.sh"]

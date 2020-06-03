FROM node:10.15.3-alpine

MAINTAINER Cryptoeconomics Lab <https://www.cryptoeconomicslab.com>

ENV DB_BASEPATH=/var/plasmadb
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

RUN apk update && apk add python make g++ curl jq
USER node
RUN npm install @layer2/operator -g

COPY wait.sh wait.sh

ENTRYPOINT ["/home/node/.npm-global/bin/layer2-operator"]

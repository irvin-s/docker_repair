FROM node:7-alpine

WORKDIR /opt/app
RUN apk --update --no-cache add bash curl jq git
RUN npm install -g bitcore

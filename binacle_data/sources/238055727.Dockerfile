FROM node:7-alpine

WORKDIR /opt/app
RUN apk --update --no-cache add bash curl jq git && \
    apk add --virtual .builddeps build-base python linux-headers musl-dev && \
    npm install -g --verbose truffle ethereumjs-testrpc && \
    apk --no-cache --purge del .builddeps && \
    rm -rf /tmp/*
RUN truffle init

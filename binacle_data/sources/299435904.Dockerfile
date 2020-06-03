FROM node:10-alpine

RUN set -ex && \
    apk --no-cache add git

WORKDIR /app

FROM node:8.11.2-alpine

RUN set -x \
  && npm install -g npm@^6.1.0 \
  && npm cache clean --force

WORKDIR /app

COPY package.json package-lock.json ./

ENV NODE_ENV production
RUN apk add --no-cache --virtual .build-deps alpine-sdk python \
  && npm ci \
  && apk del .build-deps

COPY . .

EXPOSE 4000
CMD [ "npm", "start" ]

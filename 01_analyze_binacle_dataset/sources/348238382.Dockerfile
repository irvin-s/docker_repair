FROM mhart/alpine-node:6.6.0

RUN apk add --no-cache \
  make \
  gcc \
  g++ \
  curl \
  git \
  unzip \
  zlib-dev

ENV NODE_ENV development

WORKDIR /app

ADD package.json .
RUN npm install

ADD . .

EXPOSE 3334

CMD bin/start

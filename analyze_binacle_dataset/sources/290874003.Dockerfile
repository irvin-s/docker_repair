FROM node:8.11.1-alpine

ARG API_HOST

ENV SERVER_RENDERING on
ENV API_HOST ${API_HOST}

RUN apk add --no-cache \
  ca-certificates \
  tzdata \
  curl \
  wget \
  make \
  git \
  openssh-client

ADD . /app
WORKDIR /app

RUN yarn install \
  --no-progress \
  --ignore-scripts \
  --ignore-platforms

RUN yarn dist --no-progress

EXPOSE 4000

CMD yarn dist:server

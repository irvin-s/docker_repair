FROM node:7.6.0

RUN mkdir -p /usr/src/api && \
  apt-get update && apt-get install -y curl apt-transport-https && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install yarn && npm install -g gulp-cli

WORKDIR /usr/src/api

COPY . /usr/src/api
RUN yarn;gulp babel

EXPOSE 3000

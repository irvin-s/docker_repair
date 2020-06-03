FROM node:7.6.0

RUN mkdir -p /usr/src/www && \
  apt-get update && apt-get install -y curl apt-transport-https && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install yarn && npm install -g gulp-cli

COPY . /usr/src/vue
RUN cd /usr/src/vue && yarn && yarn run build && \
  cp -r /usr/src/vue/dist/static /usr/src/www && \
  cp -r /usr/src/vue/dist/index.html /usr/src/www/index.html

WORKDIR /usr/src/www

COPY ./server /usr/src/www
RUN yarn

EXPOSE 8080

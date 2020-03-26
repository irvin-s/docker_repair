FROM node

COPY . /app
WORKDIR /app

ENV APP_ENV dev

RUN npm install
RUN npm rebuild node-sass
RUN node node_modules/.bin/r.js -o rbuild.js
RUN node node_modules/aurelia-cli/bin/aurelia-cli.js build --env $APP_ENV

EXPOSE 9000/tcp

ENTRYPOINT node node_modules/pushstate-server/bin/pushstate-server . 9000

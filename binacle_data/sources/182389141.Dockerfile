FROM node:5

MAINTAINER Daniel Demmel <dain@ustwo.com>

ENV NODE_ENV=development

WORKDIR /usr/local/src

COPY package.json /usr/local/src/package.json
RUN npm install

COPY gulpfile.js /usr/local/src/gulpfile.js
COPY .babelrc /usr/local/src/.babelrc
COPY src /usr/local/src/src
RUN npm run compile

EXPOSE 8877

CMD ["babel-node", "src/server"]

FROM node:4

MAINTAINER Rudolf Olah <omouse@gmail.com>

USER root

ENV AP /data/app
ENV PKG /data/package

COPY package.json $AP/
COPY bin/grunt2gulp.js $AP/

WORKDIR $AP/

RUN npm install

ENTRYPOINT cd $PKG/ && node $AP/grunt2gulp.js $PKG/Gruntfile.js > $PKG/gulpfile.js

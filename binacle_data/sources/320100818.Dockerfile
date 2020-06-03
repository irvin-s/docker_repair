FROM node:7.9-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

# Install Python
# https://github.com/sass/node-sass/issues/1176
RUN apk --no-cache --update add python alpine-sdk

# Install bower, gulp
RUN yarn global add bower gulp && \
    yarn cache clean && \
    rm -rf /var/cache/* /tmp/*

WORKDIR /workspace

FROM node:7.9-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

# Install bower, gulp
RUN yarn global add mocha && \
    yarn add selenium-webdriver expect.js js-yaml shelljs colors && \
    yarn cache clean && \
    rm -rf /var/cache/* /tmp/*

WORKDIR /workspace

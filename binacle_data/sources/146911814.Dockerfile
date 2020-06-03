FROM node:10-alpine as sketch-validator
WORKDIR /sketch-validator

ENV PACKAGE=packages/sketch-validator-nodejs-wrapper

COPY ${PACKAGE}/package.json ./

RUN yarn

COPY ${PACKAGE}/src ./src
COPY ${PACKAGE}/rollup.config.js \
     ${PACKAGE}/sketchlint.json \
     ${PACKAGE}/tsconfig.json ./

# copy colors file for validation
COPY packages/sketch-validator/tests/fixtures/_colors.scss \
     /sketch-validator/tests/fixtures/_colors.scss

# Copy root tsconfig
COPY ./tsconfig.json /
COPY ./config /config

RUN yarn build

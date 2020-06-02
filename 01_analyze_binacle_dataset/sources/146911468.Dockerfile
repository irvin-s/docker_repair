FROM node:10-alpine as code-analyzer
WORKDIR /code-analyzer

ENV PACKAGE=packages/code-analyzer

COPY ${PACKAGE}/package.json ./

RUN yarn

COPY ${PACKAGE}/src ./src
COPY ${PACKAGE}/rollup.config.js \
     ${PACKAGE}/tsconfig.json \
     ${PACKAGE}/config.material.json \
     ${PACKAGE}/config.json ./

# Copy root tsconfig
COPY ./tsconfig.json /
COPY ./config /config

RUN yarn build

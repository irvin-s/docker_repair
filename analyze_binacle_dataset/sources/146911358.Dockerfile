FROM node:10-alpine as app-builder
WORKDIR /app-builder

ENV PACKAGE=packages/app-builder

COPY ${PACKAGE}/package.json ./

RUN yarn

COPY ${PACKAGE}/src ./src
COPY ${PACKAGE}/tsconfig.json \
     ${PACKAGE}/config.json \
     ${PACKAGE}/config.material.json \
     ${PACKAGE}/gulpfile.js ./

# Copy root tsconfig
COPY ./tsconfig.json /
COPY ./config /config

RUN yarn build

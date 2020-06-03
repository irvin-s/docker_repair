FROM node:carbon-alpine
WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile
CMD yarn start

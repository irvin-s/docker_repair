FROM node:10-alpine

RUN mkdir /code
WORKDIR /code

COPY ./package.json ./
COPY ./yarn.lock ./
RUN yarn install --network-timeout 100000
COPY ./src ./src
COPY ./.babelrc ./
COPY ./webpack.config.js ./
RUN npx webpack --mode=production
RUN yarn babel src/cli.js --out-file dist/cli.js

ENTRYPOINT ["/usr/local/bin/node", "dist/cli.js"]

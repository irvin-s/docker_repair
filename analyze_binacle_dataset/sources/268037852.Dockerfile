FROM node:9-alpine

RUN mkdir -p /gs/client
WORKDIR /gs/client

COPY package.json yarn.lock ./

ENV NODE_ENV=development

RUN yarn

COPY .babelrc webpack.config.js ./

CMD ["yarn", "run", "watch"]

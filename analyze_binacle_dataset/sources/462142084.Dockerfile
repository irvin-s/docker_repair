# Prepare
FROM node:10.9.0-alpine AS base

WORKDIR /opt/app

# Install
FROM base AS dependencies

COPY package.json yarn.lock ./

RUN yarn --production --ignore-scripts --prefer-offline
RUN cp -R node_modules production_node_modules

RUN yarn

# Build
FROM base AS build

COPY --from=dependencies /opt/app/node_modules ./node_modules

ENV CI true
COPY tsconfig.json tslint.json ./

COPY src ./src

COPY package.json .

RUN yarn build

# Test
COPY jest.config.js .
COPY jest ./jest

RUN yarn test

# Run
FROM base AS run

COPY --from=dependencies /opt/app/production_node_modules ./node_modules
COPY --from=dependencies /opt/app/package.json .
COPY --from=build /opt/app/build ./build

ENV PORT 3001
ENV NODE_ENV production

EXPOSE $PORT

USER node

CMD [ "node", "build/server.js" ]

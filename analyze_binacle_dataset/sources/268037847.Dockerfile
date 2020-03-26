FROM node:9

RUN apt-get update \
    && apt-get install -y --no-install-recommends python \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production

RUN mkdir -p /gs/server /gs/client
WORKDIR /gs

COPY server/package.json server/yarn.lock server/
RUN cd server && yarn

COPY client/package.json client/yarn.lock client/
RUN cd client && yarn install --production=false

COPY client/src client/src
COPY client/.babelrc client/webpack.config.js client/
RUN cd client && yarn run build



FROM node:9-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends git grep \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production

RUN mkdir -p /gs/client

COPY --from=0 /gs/client/dist /gs/client/dist
COPY client/index.html /gs/client/

COPY --from=0 /gs/server /gs/server
COPY server/src /gs/server/src

WORKDIR /gs/server

CMD ["node", "src/index.js"]

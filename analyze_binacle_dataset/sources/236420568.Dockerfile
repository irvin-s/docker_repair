FROM node:boron-alpine

RUN npm install yarn --global --no-progress --silent --depth 0

WORKDIR /tmp
COPY ./package.json /tmp/
RUN yarn install 

WORKDIR /app
# prevent MemoryFileSystem.readFileSync error
RUN mkdir dist
RUN cp -a /tmp/node_modules /app/node_modules && cp -a /tmp/package.json /app/package.json

COPY ./config/ /app/config
COPY .babelrc /app/.babelrc
COPY ./src/client /app/src/client

ARG API_PORT=8080
ENV API_PORT=${API_PORT}
ARG CLIENT_PORT=8080
ENV CLIENT_PORT=${CLIENT_PORT}
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
ARG DEBUG=*
ENV DEBUG=${DEBUG}

# TODO: this one runs development way still..
CMD ["node","/app/src/client/devServer.js"]

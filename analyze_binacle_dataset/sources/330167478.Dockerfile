FROM node:8.9.4-alpine

ARG GIT_HASH
LABEL githash=${GIT_HASH}

ENV GIT_HASH=${GIT_HASH}
ENV HOME=/home/node

WORKDIR $HOME/app

COPY . $HOME/app

RUN yarn install && \
  yarn run build && \
  rm -rf node_modules && \
  NODE_ENV=production yarn install && \
  chown -R node:node $HOME/app

ENV NODE_ENV=production

USER node
CMD ["yarn", "start"]

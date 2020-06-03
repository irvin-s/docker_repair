# This dockerfile must run in the context of the project root directory.
# It uses lerna to build an image that contains latest versions of the local
# packages.
# From the root directory, run:
# docker build -t stratumn/agent-ui:local -f ./packages/agent-ui/Dockerfile.local .

FROM node:8

RUN yarn global add lerna
RUN yarn global add serve

COPY packages packages
COPY lerna.json lerna.json
COPY package.json package.json
RUN lerna bootstrap

WORKDIR /packages/agent-ui

ENV NODE_ENV production
RUN yarn build

CMD serve -s build -p 4000

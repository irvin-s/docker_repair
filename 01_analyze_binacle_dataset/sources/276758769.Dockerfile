# This dockerfile must run in the context of the project root directory.
# It uses lerna to build an image that contains latest versions of the local
# packages.
# From the root directory, run:
# docker build -t stratumn/agent:local -f ./packages/agent/Dockerfile.local .

FROM node:8

RUN yarn global add lerna

COPY packages packages
COPY lerna.json lerna.json
COPY package.json package.json
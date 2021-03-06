FROM node:10.15.1
LABEL maintainer "ODL DevOps <mitx-devops@mit.edu>"

# this dockerfile builds the hub image for the watch container
# we don't use this directly, instead we push to docker-hub, and
# then Dockerfile-travis-watch uses that pushed image to bootstrap
# itself

RUN apt-get update && apt-get install libelf1

RUN mkdir /src

WORKDIR /src

COPY package.json yarn.lock ./webpack_if_prod.sh /src/
COPY scripts /src/scripts

RUN node /src/scripts/install_yarn.js

RUN chown -R node:node /src

USER node

# this is just to get a warm cache, we delete node_modules afterwards to
# avoid issues with native extensions (mainly node-sass)
RUN yarn install --frozen-lockfile

RUN rm -rf node_modules

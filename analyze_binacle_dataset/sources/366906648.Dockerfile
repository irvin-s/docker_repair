FROM node:7-slim

# Update image and install dependencies
RUN set -x \
    && apt-get update && apt-get install -y ocaml libelf-dev git --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Prepare workdir with application code
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
COPY . /usr/src/app

# Setup environment
ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

# Install application
RUN set -x \
    && yarn install \
    && npm cache clean

# Default command when running the container
CMD [ "yarn", "start" ]

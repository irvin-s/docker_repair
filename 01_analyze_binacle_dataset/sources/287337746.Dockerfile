# Note: This Dockerfile only serves as a base for custom Pocket Nodes with specific network config (e.g. Eth, BTC, etc...)

FROM node:10-alpine
MAINTAINER Lowell Abbott <lowell@pokt.network>

# Install additional system dependencies
RUN apk --no-cache --virtual add git python bash su-exec make gcc g++ 

# Expose the default port as a hint to any other older linked containers
EXPOSE 8000 

ENV POCKET_NODE_HOME=/app

RUN mkdir -p ${POCKET_NODE_HOME}
WORKDIR ${POCKET_NODE_HOME}

# Add only the package.json and install dependencies, to minimize the rebuild of this layer
COPY package.json* .
RUN npm install

# Add the local repo files to the image. This is near the bottom to minimize image layer rebuilding.
COPY . .


# `npm install pocket-node` would normally have made this symlink, however this is a build from source.
RUN ln -s ../../src/pocket-node.js node_modules/.bin/pocket-node

ENV PATH=${POCKET_NODE_HOME}/node_modules/.bin:${POCKET_NODE_HOME}:$PATH
ENV POCKET_NODE_CONFIGURATION_DIR=${POCKET_NODE_HOME}/configuration

RUN mkdir -p ${POCKET_NODE_CONFIGURATION_DIR}
RUN echo '{}' > ${POCKET_NODE_CONFIGURATION_DIR}/plugins.json

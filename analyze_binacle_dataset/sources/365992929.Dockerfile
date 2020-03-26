FROM boomtownroi/base:latest

MAINTAINER BoomTown CNS Team <consumerteam@boomtownroi.com>

ENV NODE_VERSION 6.9.4
ENV NPM_VERSION 3.10.10

# Setup Node.js (Setup NodeSource Official PPA)
# https://github.com/nodesource/docker-node/blob/master/ubuntu/trusty/Dockerfile
RUN buildDeps='curl lsb-release python-all git apt-transport-https build-essential' && \
    apt-get update && \
    apt-get install -y --force-yes $buildDeps && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L http://git.io/n-install | N_PREFIX=/usr/local/n bash -s -- -y $NODE_VERSION
ENV PATH "$PATH:/usr/local/n/bin"

RUN npm_install=$NPM_VERSION curl -L https://www.npmjs.com/install.sh | sh

RUN npm install -g forever \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && npm config set color false

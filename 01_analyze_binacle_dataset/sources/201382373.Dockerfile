FROM debian:8.2
MAINTAINER Yen-Shuo Su <shuoshuo@gmail.com>

ENV NPM_CONFIG_LOGLEVEL info

# Install Utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends procps openssh-client git bzip2 && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN apt-get update && \
    apt-get install -y --no-install-recommends npm nodejs && \
    ln -s /usr/bin/nodejs /usr/local/bin/node && \
    mkdir -p /usr/lib/node_modules && ln -s /usr/lib/node_modules /usr/local/lib && \
    rm -rf /var/lib/apt/lists/*

## Install Gitbook
RUN npm install -d gitbook-cli svgexport -g && \
    npm cache clean && \
    gitbook -d versions:install && \
    rm -rf /tmp/npm* /tmp/tmp*

## Install OpenJDK
RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-7-jre-headless && \
    rm -rf /var/lib/apt/lists/*

## Install Calibre
RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends calibre fonts-noto fonts-noto-cjk locales-all && \
    rm -rf /var/lib/apt/lists/*

## Install Graphviz for PlantUML
RUN apt-get update && \
    apt-get install -y --no-install-recommends graphviz && \
    rm -rf /var/lib/apt/lists/*

FROM ubuntu:14.04

WORKDIR /usr/src/app

RUN apt-get update && \
    apt-get install -y \
        curl \
        git \
        && \
    curl https://deb.nodesource.com/setup_0.10 | bash - && \
    apt-get install -y \
        coffeescript \
        nodejs \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY package.json /usr/src/app

RUN npm install

# Ugly hack because the Zooniverse module references itself in lowercase,
# this is why we shouldn't develop on case-insensitive filesystems
RUN cp -a /usr/src/app/node_modules/Zooniverse /usr/src/app/node_modules/zooniverse

COPY . /usr/src/app

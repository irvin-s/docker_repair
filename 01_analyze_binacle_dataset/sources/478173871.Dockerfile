FROM ubuntu:14.04

ENV NODE_VERSION 7.2.0

RUN apt-get update && apt-get install -y \
    curl git bzip2 g++ python=2.7.5-5ubuntu3 make

RUN curl -L -o /tmp/nodejs.tar.gz https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz \
    && tar xfvz /tmp/nodejs.tar.gz -C /usr/local --strip-components=1 \
    && rm -r /tmp/nodejs.tar.gz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g yarn

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

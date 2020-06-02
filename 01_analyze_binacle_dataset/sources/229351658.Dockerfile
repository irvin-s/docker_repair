FROM	debian:wheezy

MAINTAINER Automattic

WORKDIR /calypso-live-branches

RUN     apt-get -y update && apt-get -y install \
          wget \
          git \
          python \
          make \
          build-essential

ENV NODE_VERSION 4.2.3

RUN     wget https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz && \
          tar -zxf node-v$NODE_VERSION-linux-x64.tar.gz -C /usr/local && \
          ln -sf node-v$NODE_VERSION-linux-x64 /usr/local/node && \
          ln -sf /usr/local/node/bin/npm /usr/local/bin/ && \
          ln -sf /usr/local/node/bin/node /usr/local/bin/ && \
          rm node-v$NODE_VERSION-linux-x64.tar.gz

# Install base npm packages to take advantage of the docker cache
COPY    ./package.json /calypso-live-branches/package.json
RUN     npm install --production

COPY    . /calypso-live-branches

# Change ownership
RUN     chown -R nobody /calypso-live-branches

VOLUME [ "/data" ]
EXPOSE 3000

#USER    nobody
ENV     TMP_DIR /data
ENV     DEBUG server,worker,branch-manager
CMD     node lib/index.js calypso.json

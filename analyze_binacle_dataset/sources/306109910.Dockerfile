FROM ubuntu:16.04

# Expose network ports
EXPOSE 4200

# Docker-based quirks
ENV LANG C.UTF-8
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
 
# Distinct (Docker vs Vagrant) env variables
ENV NODE_VERSION 9.3.0
ENV NVM_DIR /usr/local/nvm
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV USER_DIR="/root"
 
# # System-based package isntallation
RUN apt-get update -y && \
    apt-get install -y wget

# Chrome installation
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update -y && \
    apt-get install -y google-chrome-stable

# Node installation
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
RUN . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

ADD . /volontulo/frontend
WORKDIR /volontulo/frontend

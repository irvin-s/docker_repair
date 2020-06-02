FROM ubuntu:14.04.3

MAINTAINER Kyle Campbell <kc@kc.io>

ENV TERM xterm

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

RUN apt-get update
RUN apt-get -y install sudo

RUN apt-get install -y build-essential \
  software-properties-common \
  chrpath \
  libfontconfig1-dev \
  git \
  git-core \
  g++ \
  curl \
  libssl-dev \
  openssl \
  apache2-utils \
  pkg-config \
  make \
  openssh-server \
  libkrb5-dev

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN mkdir -p /src && mkdir -p /src/app
RUN chown -R docker:docker /src

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.9.5

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v

ADD .eslintignore /src/app
ADD .eslintrc /src/app
ADD .nvmrc /src/app
ADD config /src/app/config
ADD src/ /src/app/src
ADD static /src/app/static
ADD test /src/app/test
ADD index.js /src/app
ADD package.json /src/app

EXPOSE 80:3030
EXPOSE 443:3030
WORKDIR /src/app

RUN npm install -g pm2 yarn
RUN yarn install

CMD pm2-docker index.js

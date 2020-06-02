#################################
# Node js

## Using google as example: https://hub.docker.com/r/google/nodejs/~/dockerfile/
# FROM debian:jessie

## Using alpine https://github.com/mhart/alpine-node
FROM mhart/alpine-node:6.7.0
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

ENV TERM xterm

# #################################
# Install prerequisites
RUN apk add --no-cache vim wget bash git

# RUN apt-get update -y && apt-get install --no-install-recommends -y -q \
#     curl python build-essential git ca-certificates
# # Install NodeJs 4
# RUN curl --silent --location https://deb.nodesource.com/setup_6.x | bash -
# RUN apt-get install --yes nodejs

# #################################
# Bug fix
# https://github.com/npm/npm/issues/9863#issue-110074625

RUN cd $(npm root -g)/npm \
  && npm install fs-extra \
  && sed -i -e s/graceful-fs/fs-extra/ -e s/fs\.rename/fs.move/ ./lib/utils/rename.js

# #################################
# Install development packages
RUN npm install --global npm@latest \
    && npm install --global graceful-fs graceful-fs@latest \
    && npm install --global \
        express socket.io \
        gulp nodemon \
        rethinkdb \
        bower \
        # bower-installer \
        # bootstrap \
        angular angular-socket-io \
        # angular-ui-router \
        # karma karma-cli karma-chrome-launcher \
        # karma-jasmine jasmine-core jasmine \
    && npm cache clean

ENV NODE_PATH /usr/lib/node_modules

# #################################
# Development user
ENV MAINDIR /devjs
ENV HOMEDIR /home/dev
RUN mkdir -p $MAINDIR

ENV NEWUSER developer
RUN mkdir -p $HOMEDIR
RUN adduser -h $HOMEDIR -D $NEWUSER
# RUN useradd $NEWUSER -d $HOMEDIR
RUN chown -R $NEWUSER $HOMEDIR && chown -R $NEWUSER $MAINDIR

USER $NEWUSER
WORKDIR $MAINDIR
# Remove bower for asking about statistics...
RUN yes | bower

# EXPOSE 3000
# CMD ["node", "index.js"]

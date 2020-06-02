# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Guillaume Gouchon

# Install Node.js and other dependencies
RUN apt-get update && \
    apt-get -y install curl && \
    curl -sL https://deb.nodesource.com/setup | sudo bash - && \
    apt-get -y install python build-essential nodejs

# Install nodemon
RUN npm install -g forever

# Provides cached layer for node_modules
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p / && cp -a /tmp/node_modules /

# Define working directory
ADD . /

ENV NODE_ENV production

# Run app using forever
CMD forever server.js

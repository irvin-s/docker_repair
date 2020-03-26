FROM mhart/alpine-node:4
ENV NPM_VERSION=4.6.1

# Install Dependencies

RUN apk add --no-cache make gcc g++ python
RUN rm -rf /var/cache/apk/*

RUN npm i -g npm@$NPM_VERSION

RUN addgroup -S meteor
RUN adduser -S meteor -G meteor -s /bin/sh

# Install Meteor App

COPY bundle /home/meteor/bundle

WORKDIR /home/meteor/bundle/programs/server
RUN npm install

# Start the App!

WORKDIR /home/meteor/bundle
ENTRYPOINT ["node", "main.js"]

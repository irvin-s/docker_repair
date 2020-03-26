FROM mhart/alpine-node:10.5.0
MAINTAINER	Henning Störk <stoerk+github@gmail.com>

# Create app directory
RUN mkdir -p /usr/src/node-influx-uptimerobot
COPY index.js /usr/src/node-influx-uptimerobot/
COPY package.json /usr/src/node-influx-uptimerobot/
WORKDIR /usr/src/node-influx-uptimerobot

# Install app dependencies
RUN npm install

CMD node index.js

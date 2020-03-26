FROM node:8-alpine
ADD package.json /tmp/package.json
RUN cd /tmp && yarn install
RUN mv /tmp/node_modules /node_modules
WORKDIR /
ADD . /
CMD node server.js
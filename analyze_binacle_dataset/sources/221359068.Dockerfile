FROM mhart/alpine-node:6.2.0

RUN apk add --no-cache curl git

COPY package.json /usr/src/app/package.json
RUN cd /usr/src/app && npm install --production
COPY . /usr/src/app
RUN cd /usr/src/app && rm -rf .eslintrc test
WORKDIR /usr/src/app

RUN apk del curl git
RUN rm -rf /tmp/*

ENV PATH="$PATH:/usr/src/app/node_modules/.bin"

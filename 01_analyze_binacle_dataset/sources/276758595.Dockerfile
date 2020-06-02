FROM node:8.9.1-alpine

RUN apk add --no-cache git make gcc g++ python

RUN mkdir /agent-sample

ADD package.json /agent-sample/package.json
ADD yarn.lock /agent-sample/yarn.lock
RUN cd /agent-sample; yarn install
ADD . /agent-sample/
WORKDIR /agent-sample

ENV NODE_ENV production
CMD ["yarn", "start"]
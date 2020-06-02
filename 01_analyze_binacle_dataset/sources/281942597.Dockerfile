FROM mhart/alpine-node:9.2.0

RUN apk update && apk add --no-cache --virtual build-dependencies git python g++ make
RUN yarn global add truffle@4.0.6

RUN mkdir -p /deploy/vault
WORKDIR /deploy/vault

# First add deps
ADD ./package.json /deploy/vault/
ADD ./package-lock.json /deploy/vault/
RUN yarn

# Then rest of code and build
ADD . /deploy/vault

RUN truffle compile

RUN apk del build-dependencies
RUN yarn cache clean

CMD while :; do sleep 2073600; done

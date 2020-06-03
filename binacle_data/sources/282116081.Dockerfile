FROM node:9.2-stretch

WORKDIR /project
ADD dapp dapp

WORKDIR /project/dapp
RUN yarn

ADD production/ci/integration/dapp/truffle-config.js .

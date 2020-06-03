FROM node:lts-alpine
ARG BUILD_DEPS="git g++ cmake make python2"
WORKDIR /opt/leap-node
RUN apk add --no-cache --update --virtual build_deps $BUILD_DEPS
COPY . /opt/leap-node
RUN yarn install --production
RUN yarn link
RUN apk del build_deps

ENV NO_VALIDATORS_UPDATES "false"
ENV RPC_ADDR "0.0.0.0"
ENV RPC_PORT "8645"
ENV WS_ADDR "0.0.0.0"
ENV WS_PORT "8646"
ENV P2P_PORT "46691"
ENV TENDERMINT_ADDR "0.0.0.0"
ENV READONLY "false"
ENV UNSAFE_RPC "false"
# Either CONFIG_URL or NETWORK needs to be defined, CONFIG_URL takes precedence
ENV CONFIG_URL "http://node1.testnet.leapdao.org:8645"
# for presets/leap-NETWORK
ENV NETWORK "testnet"
# Needed if validator
ENV PRIVATE_KEY ""
ENTRYPOINT ["leap-node"]

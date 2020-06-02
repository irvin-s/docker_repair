FROM node:9-stretch

ARG CI
ENV CI=$CI
ENV PROJECT_TYPE="server"

VOLUME [ "/opt/orbs/logs", "/opt/orbs/db" ]

ADD package.json yarn.lock .yarnrc docker/bootstrap-server.sh /opt/orbs/

WORKDIR /opt/orbs

RUN ./bootstrap-server.sh

RUN yarn config list && \
    yarn global add typescript@2.7.1 tslint@5.9.1 && \
    yarn install && yarn cache clean

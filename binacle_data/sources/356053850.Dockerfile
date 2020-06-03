# Copyright 2016, EMC, Inc.

ARG repo=rackhd
ARG tag=devel

FROM ${repo}/on-tasks:${tag}

COPY . /RackHD/on-http/
WORKDIR /RackHD/on-http

RUN mkdir -p ./node_modules \
  && apt-get update \
  && apt-get install -y unzip curl \
  && npm install apidoc@^0.12.1 \
  && npm install --production \
  && npm run taskdoc \
  && /RackHD/on-http/install-web-ui.sh \
  && /RackHD/on-http/install-swagger-ui.sh \
  && rm -r ./node_modules/on-tasks ./node_modules/on-core ./node_modules/di \
  && ln -s /RackHD/on-tasks ./node_modules/on-tasks \
  && ln -s /RackHD/on-core ./node_modules/on-core \
  && ln -s /RackHD/on-core/node_modules/di ./node_modules/di

EXPOSE 9080 9090
VOLUME /RackHD/on-http/static/http/common
CMD [ "node", "/RackHD/on-http/index.js" ]

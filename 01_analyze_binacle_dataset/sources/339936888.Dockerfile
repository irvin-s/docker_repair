FROM ubuntu:18.04

RUN apt update -y && apt install git make zip wget xz-utils -y

WORKDIR /tmp

RUN wget -q --no-check-certificate https://nodejs.org/dist/v8.11.2/node-v8.11.2-linux-x64.tar.xz
RUN tar xf /tmp/node-v8.11.2-linux-x64.tar.xz
RUN ln -sf /tmp/node-v8.11.2-linux-x64/bin/* /usr/bin && node --version

WORKDIR /opt/button

ADD package.json package.json
RUN npm install --unsafe-perm

ADD app app
ADD bin bin
ADD src src
ADD Gulpfile.js Gulpfile.js

RUN npm run source && npm run release

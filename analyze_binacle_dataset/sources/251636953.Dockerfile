FROM node:8.9-alpine

ENV NODE_PATH /install/node_modules/
ENV PATH /install/node_modules/.bin:$PATH

COPY package.json /install/package.json
WORKDIR /install/
RUN apk --no-cache add --virtual native-deps \
  g++ gcc libgcc libstdc++ linux-headers make python && \
  npm install --quiet node-gyp -g &&\
  npm install --quiet && \
  apk del native-deps g++ gcc linux-headers make python 

VOLUME /app
WORKDIR /app

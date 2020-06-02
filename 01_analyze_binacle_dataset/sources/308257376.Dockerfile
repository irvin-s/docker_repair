FROM node:10-alpine
LABEL MAINTAINER="https://github.com/DarkKowalski/"
# Create app directory
WORKDIR /usr/src/app
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available
COPY package*.json .
ARG USE_CHINA_NPM_REGISTRY=0;
RUN if [ "$USE_CHINA_NPM_REGISTRY" = 1 ]; then \
  echo 'use npm mirror'; npm config set registry https://registry.npm.taobao.org; \
  fi;
# Install app dependencies
RUN npm set progress=false \
  && npm config set depth 0 \
  && npm install --only=production \
  && npm cache clean --force
# Bundle app source
COPY . .

CMD [ "node", "index.js" ]

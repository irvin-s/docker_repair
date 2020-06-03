FROM node:slim

MAINTAINER alaxallves@gmail.com

# Forcing Docker builds not to use its cached dependencies

COPY package.json /tmp/package.json
RUN apt-get update && apt-get install -y nodejs tree libfontconfig bzip2
RUN cd /tmp && npm install
RUN mkdir -p /usr/src/app && \
    cp -a /tmp/node_modules /usr/src/app

WORKDIR /usr/src/app
COPY . /usr/src/app

RUN npm run build

# Removing unnecessary dependencies to deploy

RUN rm -rf ./build
RUN rm -rf ./test
RUN rm -rf ./src

EXPOSE 80

ENTRYPOINT [".scripts/sh/start-homolog.sh"]

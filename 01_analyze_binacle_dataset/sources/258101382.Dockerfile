FROM node:6

ENV NPM_CONFIG_LOGLEVEL warn

RUN mkdir /data
WORKDIR /data

COPY package.json /data/
RUN npm install

COPY . /data/

CMD ["node_modules/.bin/gulp", "build"]

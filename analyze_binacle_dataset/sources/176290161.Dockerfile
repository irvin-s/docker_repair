FROM node:latest

RUN npm install -loglevel warn -g grunt-cli
ENV ROOT /opt/hearthcards
RUN mkdir -p $ROOT
WORKDIR /opt/hearthcards
COPY package.json $ROOT
RUN npm install -loglevel warn
COPY . $ROOT
CMD ./run.sh

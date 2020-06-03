FROM quay.io/ivanvanderbyl/docker-nightmare:latest
MAINTAINER "Ivan Vanderbyl <ivan@flood.io>"

ADD . /workspace
RUN yarn install

CMD "index.js"

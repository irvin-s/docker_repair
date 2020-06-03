FROM node:4
MAINTAINER Patrik Votocek <patrik@votocek.cz>

RUN apt-get update -yqq && \
    apt-get upgrade -yqq && \
    apt-get install imagemagick -yqq && \
    npm install -g -q gulp yarn && \
    apt-get clean -yqq && \
    apt-get autoremove -yqq

FROM ubuntu:16.04

MAINTAINER Kim Stebel <kim.stebel@gmail.com>

USER root

RUN apt-get update && apt-get install -yq \
    docker.io \
    nodejs-legacy \
    npm \
    python \
    git && \
    npm install -g bower && \
    npm install -g requirejs && \
    npm install -g coffee-script

WORKDIR /projects

CMD rm -rf thebe && \
    git clone https://github.com/kimstebel/thebe.git thebe && \
    cd thebe && \
    coffee -cbm . && \
    bower --allow-root --no-interactive install && \
    cd static && \
    r.js -o build.js baseUrl=. name=almond include=main out=main-built.js

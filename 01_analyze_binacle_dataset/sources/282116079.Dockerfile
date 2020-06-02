FROM node:9.2-stretch

RUN set -e -x ;\
    apt-get -y update ;\
    apt-get -y install protobuf-compiler ;\
    rm -rf /var/lib/apt/lists/*

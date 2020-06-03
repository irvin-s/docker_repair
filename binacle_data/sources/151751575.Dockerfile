FROM ubuntu:14.04

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

ENV MONGODB_VERSION 2.6.5

RUN apt-get update && \
  apt-get install -qy \
  mongodb-org=$MONGODB_VERSION \
  mongodb-org-server=$MONGODB_VERSION \
  mongodb-org-shell=$MONGODB_VERSION \
  mongodb-org-mongos=$MONGODB_VERSION \
  mongodb-org-tools=$MONGODB_VERSION && \
  mkdir -p /data/db && \
  chown mongodb:mongodb /data/db

EXPOSE 27017
USER mongodb

ENTRYPOINT ["/usr/bin/mongod"]

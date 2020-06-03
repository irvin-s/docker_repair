# MongoDB Dockerfile
# https://github.com/bigcontainer/bigcont/mongodb
FROM centos:7

ARG MONGODB_VERSION=3.2

ADD \
    mongodb-org-${MONGODB_VERSION}.repo /etc/yum.repos.d/mongodb-org-${MONGODB_VERSION}.repo

RUN \
    yum install -y mongodb-org

RUN mkdir -p /data/db

EXPOSE 27017

ENTRYPOINT ["/usr/bin/mongod"]

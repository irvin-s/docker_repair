# Pull base image.
FROM centos:7

MAINTAINER Phillipp Ohlandt, DeepstreamIO

RUN yum install -y wget

RUN wget https://bintray.com/deepstreamio/rpm/rpm -O /etc/yum.repos.d/bintray-deepstreamio-rpm.repo

RUN yum install -y deepstream.io-2.1.1-1

# Installing Plugins
RUN deepstream install storage postgres && \
    deepstream install storage elasticsearch && \
    deepstream install storage mongodb && \
    deepstream install storage rethinkdb && \
    deepstream install cache redis && \
    deepstream install cache hazelcast && \
    deepstream install cache memcached && \
    deepstream install msg kafka && \
    deepstream install msg amqp && \
    deepstream install msg redis

# Expose ports

# HTTP Port
EXPOSE 6020

# Define default command.
CMD [ "deepstream" ]

FROM centos:7

MAINTAINER Phillipp Ohlandt, DeepstreamIO

RUN yum install -y wget

RUN wget https://bintray.com/deepstreamio/rpm/rpm -O /etc/yum.repos.d/bintray-deepstreamio-rpm.repo

RUN yum install -y deepstream.io-3.1.0

# Installing Plugins
RUN deepstream install storage postgres && \
    deepstream install storage elasticsearch && \
    deepstream install storage mongodb && \
    deepstream install storage rethinkdb && \
    deepstream install cache redis && \
    deepstream install cache hazelcast && \
    deepstream install cache memcached

# ws port
EXPOSE 6020

# http port
EXPOSE 8080

# Define default command.
CMD [ "deepstream" ]

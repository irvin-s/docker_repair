# Docker build file to create an image with centos 7
FROM centos:7
MAINTAINER andreas-bok-sociomantic <andreas.bok@sociomantic.com>

# add repos for additional compiler toolsets
RUN curl http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm -o /tmp/epel-release-7-11.noarch.rpm
RUN rpm -Uvh /tmp/epel-release*rpm

# install required packages
RUN yum install -y deltarpm && \
yum install -y rpm-build zlib-devel libtool openssl \
    openssl-devel automake autoconf gcc-c++

RUN yum install -y centos-release-scl

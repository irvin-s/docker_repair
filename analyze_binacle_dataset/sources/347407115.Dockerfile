FROM scratch
MAINTAINER Steffen Bleul <sbl@blacklabelops.com>
ADD blacklabelops-centos7.xz /
RUN yum update -y && \
    yum clean all && rm -rf /var/cache/yum/* && rm -rf /var/log/*

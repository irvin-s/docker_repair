FROM centos:7
MAINTAINER Castedo Ellerman <castedo@castedo.com>

RUN yum update -y \
 && yum install -y epel-release \
 && yum update -y \
 && cd /etc/yum.repos.d/ \
 && curl -O "http://dist.brokertron.com/repo/centos/7/brokertron.repo"

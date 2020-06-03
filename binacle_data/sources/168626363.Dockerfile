#
#   Author: Rohith
#   Date: 2014-10-20 22:03:46 +0100 (Mon, 20 Oct 2014)
#
#  vim:ts=2:sw=2:et
#
FROM ubuntu:latest
MAINTAINER <gambol99@gmail.com>
RUN sudo apt-get update -y
RUN sudo apt-get install --fix-missing -y wget curl golang git
RUN sudo wget http://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64 -O /usr/bin/confd && chmod +x /usr/bin/confd
RUN sudo curl -L https://github.com/coreos/etcdctl/archive/v0.4.5.tar.gz | tar zxv -C /opt; \
 cd /opt/etcd*; \
 mkdir -p /root/go; \
 export GOPATH=$HOME/go; \
 ./build; \
 cp bin/etcdctl /usr/bin/etcdctl;
RUN sudo mkdir -p /etc/confd/conf.d /etc/confd/templates
RUN sudo apt-get install -y vim
ADD config/confd.conf /etc/confd/confd.conf
ENV ENVIRONMENT dev
ENV APP confd
ENV NAME confd

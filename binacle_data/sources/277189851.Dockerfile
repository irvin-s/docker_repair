FROM centos:7
MAINTAINER Junegunn Choi <jg.choi@kakaocorp.com>

RUN yum clean all && yum install -y rpm-build rpmdevtools createrepo

WORKDIR /root

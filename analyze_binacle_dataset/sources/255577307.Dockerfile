FROM openshift/base-centos7

MAINTAINER Luis Fernando Gomes <your@luiscoms.com.br>

ENV ERLANG_SOLUTIONS_VERSION 1.0-1
RUN yum update -y && yum clean all
RUN yum install -y wget && yum clean all
RUN yum install -y http://packages.erlang-solutions.com/erlang-solutions-${ERLANG_SOLUTIONS_VERSION}.noarch.rpm && yum clean all
RUN yum install -y erlang && yum clean all
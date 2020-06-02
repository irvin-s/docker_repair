FROM centos:6.6
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>

RUN yum install -y squid

RUN mkdir /setup
ADD . /setup
WORKDIR /setup

CMD ./start-squid.sh
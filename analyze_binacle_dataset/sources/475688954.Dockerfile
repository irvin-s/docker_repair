FROM ubuntu:trusty
MAINTAINER GoCD Team <go-cd@googlegroups.com>

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install git software-properties-common python-software-properties
RUN add-apt-repository ppa:ubuntu-lxc/lxd-stable
RUN apt-get update
RUN apt-get -y install golang

ADD gocd-golang-agent gocd-golang-agent

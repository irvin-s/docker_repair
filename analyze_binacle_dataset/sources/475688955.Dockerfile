FROM ubuntu:trusty
MAINTAINER GoCD Team <go-cd@googlegroups.com>

# install gocd-golang-agent
RUN echo deb https://dl.bintray.com/alex-hal9000/gocd-golang-agent master main | tee -a /etc/apt/sources.list
RUN apt-get -y install apt-transport-https
RUN apt-get -y update
RUN apt-get -y --force-yes install gocd-golang-agent

# add ubuntu-lxc apt-get repo (for newer version of golang)
RUN apt-get -y install software-properties-common python-software-properties
RUN add-apt-repository ppa:ubuntu-lxc/lxd-stable
RUN apt-get -y update

# install project specific packages
RUN apt-get -y install golang git

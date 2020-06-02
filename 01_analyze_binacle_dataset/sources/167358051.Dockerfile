FROM ubuntu
MAINTAINER Tony Chong

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

WORKDIR /tmp

# The bare necessities
RUN apt-get install -y wget curl apt-transport-https openjdk-7-jre-headless
# So can switch between deb packages and a repo for testing
RUN wget http://downloads.mesosphere.io/master/ubuntu/14.04/mesos_0.20.1-1.0.ubuntu1404_amd64.deb -O mesos_0.20.1-1.0.ubuntu1404_amd64.deb

# Get the latest repos
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF 
RUN echo deb http://repos.mesosphere.io/ubuntu trusty main > /etc/apt/sources.list.d/mesosphere.list 
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
RUN apt-get -y update 

# You need docker installed
RUN apt-get install -y lxc-docker

# This is where you can switch out how you want to install stuff
RUN dpkg -i mesos_0.20.1-1.0.ubuntu1404_amd64.deb
#RUN apt-get install mesos -y

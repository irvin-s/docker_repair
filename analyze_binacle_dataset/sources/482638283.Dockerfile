FROM java:latest
MAINTAINER Brad Futch <brad@galacticfog.com>
RUN echo 'deb http://repos.mesosphere.io/ubuntu/ trusty main' > /etc/apt/sources.list.d/mesosphere.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN apt-get -y update
RUN apt-get -y install mesos=0.28.1-2.0.20.ubuntu1404

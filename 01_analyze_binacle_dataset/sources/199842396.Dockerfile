FROM ubuntu:14.04

RUN echo "deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu trusty main" > /etc/apt/sources.list.d/openjdk.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv 86F44E2A && \
  apt-get update && \
  apt-get -y install openjdk-8-jre-headless && \
  rm -rf /var/lib/apt/lists/*

RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
  apt-get -y update && \
  apt-get -y install mesos=0.25.0-0.2.70.ubuntu1404 && \
  rm -rf /var/lib/apt/lists/*

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD mesosframework-*.jar /tmp/mesosframework.jar
ADD docker-entrypoint.sh /tmp/docker-entrypoint.sh

# Use baseimage-docker's init system.
ENTRYPOINT ["/tmp/docker-entrypoint.sh"]
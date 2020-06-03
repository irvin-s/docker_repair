#
# Java Dockerfile
#
# Based off of https://github.com/dockerfile/java
#

# Pull base image.
FROM dockerfile/ubuntu
MAINTAINER Nikhil Vaze

# Install Java.
RUN \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer

#Jetty
RUN adduser --system jetty
RUN mkdir /opt/jetty

# Assumes jetty.tar.gz and jpetstore.war are next to this Dockerfile
ADD jetty.tar.gz /opt/jetty
ADD jpetstore.war /opt/jetty/jetty-distribution-8.1.15.v20140411/webapps/jpetstore.war

RUN chown -R jetty /opt/jetty

# Define default command.
CMD ["/opt/jetty/jetty-distribution-8.1.15.v20140411/bin/jetty.sh", "-d", "run"]
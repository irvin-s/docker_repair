#
# Java Dockerfile
#
# https://github.com/rossbachp/dockerbox/docker-images/java7
#

# Pull base image.
FROM ubuntu:14.04
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

ENV JAVAVERSION 7

RUN \
  apt-get update && \
  apt-get install -y curl software-properties-common

# Install Java and clean up download cache.
RUN \
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java${JAVAVERSION}-installer
RUN \
  rm -rf /var/cache/oracle-jdk${JAVAVERSION}-installer && \
  rm -f /usr/lib/jvm/java-${JAVAVERSION}-oracle/src.zip && \
  rm -f /usr/lib/jvm/java-${JAVAVERSION}-oracle/javafx-src.zip && \
  rm -rf /usr/share/doc /usr/share/man && \
  apt-get --purge remove -y software-properties-common && \
  apt-get autoremove -y && \
  apt-get clean

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]

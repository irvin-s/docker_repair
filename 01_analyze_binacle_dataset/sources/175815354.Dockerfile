FROM nimmis/ubuntu:14.04

MAINTAINER nimmis <kjell.havneskold@gmail.com>

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

# set default java environment variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/

RUN add-apt-repository ppa:webupd8team/java -y && \
echo debconf shared/accepted-oracle-license-v1-1 select true |  debconf-set-selections && \
echo debconf shared/accepted-oracle-license-v1-1 seen true |  debconf-set-selections && \
apt-get update && \
apt-get install -y --no-install-recommends oracle-java8-installer && \
apt-get install -y --no-install-recommends oracle-java8-set-default && \
rm -rf /var/cache/oracle-jdk8-installer && \
rm -rf /var/lib/apt/lists/*



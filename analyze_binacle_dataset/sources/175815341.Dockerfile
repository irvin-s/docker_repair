FROM nimmis/ubuntu:14.04

MAINTAINER nimmis <kjell.havneskold@gmail.com>

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

# set default java environment variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN add-apt-repository ppa:openjdk-r/ppa -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends openjdk-8-jre-headless && \
    rm -rf /var/lib/apt/lists/* 

# workaround for bug on ubuntu 14.04 with openjdk-8-jre-headless

RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure



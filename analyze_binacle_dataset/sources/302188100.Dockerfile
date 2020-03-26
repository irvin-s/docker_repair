FROM ubuntu:16.04

ARG PACKAGE_CNF
ARG PACKAGE_KEY

ENV DEBIAN_FRONTEND=noninteractive

################# INSTALLING BASICS #################
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get autoremove -y
RUN apt-get install -y apt-transport-https
RUN apt-get install -y apt-utils

################# INSTALLING MISC UTILS #################
RUN apt-get install -y python-flask
RUN apt-get install -y python-flask-api
RUN apt-get install -y rsync
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y vim

################# INSTALLING ZIMBRA CORE #################
RUN useradd -d /opt/zimbra -s /bin/bash -r zimbra

# Trick build into skipping resolvconf as docker overrides for DNS
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

# Access to package repository
COPY $PACKAGE_CNF /etc/apt/sources.list.d/zimbra.list
COPY $PACKAGE_KEY /tmp/key.txt
COPY ./BUILDS/latest /build
RUN ls -AFlh /build/archives/zimbra-foss/u16

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys `cat /tmp/key.txt | head` && rm -f /tmp/key.txt
RUN apt-get update
RUN apt-get install -y rsyslog
RUN apt-get install -y zimbra-core

# FIXME - the following should be part of appropriate package
RUN mkdir /opt/zimbra/conf/ca
RUN chown zimbra.zimbra /opt/zimbra/conf/ca
RUN [ "sed", "-i", "-e", "s/^\\(my .LOGHOST\\)=\\(qx.*\\);/\\1=(!@ARGV || $ARGV[0] eq 'remote') ? \\2 : '';/", "-e", "s/destination mail { /destination mail \\\\{ /", "/opt/zimbra/libexec/zmsyslogsetup" ]

WORKDIR /opt/zimbra

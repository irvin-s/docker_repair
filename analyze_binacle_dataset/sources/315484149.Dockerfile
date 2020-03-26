FROM debian:stretch

MAINTAINER ping@mirceaulinic.net

## Install min deps
RUN apt-get update \
  && apt-get install -y apt-utils \
  && apt-get install -y wget \
  && apt-get install -y gnupg \
  && apt-get install -y git \
  && rm -rf /var/lib/apt/lists/*

## Setup sources for Jessie backports and SaltStack repo
RUN echo 'deb http://httpredir.debian.org/debian stretch-backports main' >> /etc/apt/sources.list \
    && echo 'deb http://repo.saltstack.com/apt/debian/9/amd64/archive/2017.7.5/ stretch main' >> /etc/apt/sources.list.d/saltstack.list \
    && wget -O - https://repo.saltstack.com/apt/debian/9/amd64/archive/2017.7.5/SALTSTACK-GPG-KEY.pub | apt-key add - \
    && apt-get update

## Install backports
RUN apt-get install -y python-zmq

## Install the Salt Master
RUN apt-get install -y salt-master=2017.7.5+ds-1

ADD master /etc/salt/master

# Add Run File
ADD run-master.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Ports
EXPOSE 4505 4506

# Run Command
CMD "/usr/local/bin/run.sh"

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

## Install Salt packages
## salt-proxy is already included in salt-minion when installing from the SaltStack repos
RUN apt-get install -y salt-minion=2017.7.5+ds-1

## Copy the Proxy config file
ADD proxy /etc/salt/proxy

## Install NAPALM & underlying libraries dependencies
## Will install all NAPALM sub-libraries
RUN apt-get install -y python-cffi python-dev libxslt1-dev libssl-dev libffi-dev \
    && apt-get install -y python-pip \
    && pip install -U cffi \
    && pip install -U cryptography \
    && pip install napalm

# Add Run File
ADD run-proxy.sh /usr/local/bin/run-proxy.sh
RUN chmod +x /usr/local/bin/run-proxy.sh

# Run Command
CMD "/usr/local/bin/run-proxy.sh"

# A working environment preconfigured to run the tools required to create a
# Docker private registry in Azure.

FROM phusion/baseimage:0.9.10

MAINTAINER Fernando Correia <fernandoacorreia@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy install software-properties-common npm nodejs-legacy
RUN npm install azure-cli -g
RUN DEBIAN_FRONTEND=noninteractive apt-add-repository ppa:rquillo/ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get -qqy install ansible apache2-utils
ADD config /root/config

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

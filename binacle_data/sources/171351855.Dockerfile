# dnsmasq-etcd
#
# VERSION  0.1.0
#
# Use phusion/baseimage as base image.
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
#
FROM phusion/baseimage:0.9.15
MAINTAINER Jose Riguera <jriguera@gmail.com>

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Delete ssh_gen_keys
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Update
RUN apt-get update

# Dnsmasq
RUN apt-get install -y dnsmasq 
 
# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-pip 

# Dependencies for python-etcd
RUN apt-get install -y python-openssl libffi-dev libssl-dev

# Get pip to download and install requirements:
RUN pip install python-etcd

# prepare to run
ADD etcd-leases.py /usr/bin/
ADD bin/ /usr/bin/
ADD confd/ /etc/confd/
ADD init/ /etc/my_init.d/

# Enable or disable pipework by defining the location 
#ENV PIPEWORK_BIN /usr/bin/pipework
ENV CONFD_BIN /usr/bin/confd

# runinit
RUN mkdir /etc/service/confd
ADD confd.sh /etc/service/confd/run
RUN mkdir /etc/service/dnsmasq
ADD dnsmasq.sh /etc/service/dnsmasq/run

EXPOSE 53

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


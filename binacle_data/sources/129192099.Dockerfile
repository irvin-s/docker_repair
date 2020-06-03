# riak
# this file is at https://github.com/lexlapax/dockerfile-riak/blob/master/Dockerfile
# based on https://github.com/hectcastro/docker-riak
# with changes to not use pipeworks for creating a cluster
# see https://github.com/lexlapax/dockerfile-riak/blob/master/README.md

FROM ubuntu:precise
MAINTAINER Lex Lapax <lexlapax@gmail.com>

# Update the APT cache
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y


# Install and setup project dependencies
RUN apt-get install -y curl lsb-release supervisor openssh-server

RUN mkdir -p /var/run/sshd

RUN locale-gen en_US en_US.UTF-8

# Hack for initctl
# See: https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl


ADD https://raw.github.com/lexlapax/dockerfile-riak/master/etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN echo 'root:basho' | chpasswd

# Add Basho's APT repository
RUN curl http://apt.basho.com/gpg/basho.apt.key | apt-key add -
RUN echo "deb http://apt.basho.com $(lsb_release -sc) main" >> /etc/apt/sources.list.d/basho.list

RUN apt-get update

# Install Riak and prepare it to run
RUN apt-get install -y riak

# fix the configs in /etc/riak/app.config and /etc/riak/vm.args
# app.config
#  -listen address
#  -leveldb backend
#  -enable admin panel
#  -enable ssl for admin panel
#  -admin user
#  -/etc/default/riak - for nodename and ulimit
ADD https://raw.github.com/lexlapax/dockerfile-riak/master/fixconfigs.sh /home/root/fixconfigs.sh
RUN /bin/bash /home/root/fixconfigs.sh

# Expose Protocol Buffers and HTTP interfaces
EXPOSE 8087 8098 8069 22

CMD ["/usr/bin/supervisord"]

# BASE IMAGE:  https://github.com/phusion/baseimage-docker
# VERSIONS:    https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
FROM phusion/baseimage:0.9.15

MAINTAINER Roberto Lobo <rhlobo@gmail.com>

# Setting environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Disabling SSH access
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Configuring language
RUN apt-get update --quiet
RUN apt-get install --yes --quiet language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# Service Setup
ADD setup-ubuntu_14.04_x64.sh /home/docker/setup.sh
RUN /home/docker/setup.sh

# Clean up APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

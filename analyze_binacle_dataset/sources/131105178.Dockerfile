FROM rhlobo/base-bigtempo

MAINTAINER Roberto Lobo <rhlobo@gmail.com>

# Setting environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Disabling SSH access
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
# CMD ["/sbin/my_init"]

# APP SETUP
ADD . /home/docker/files/

# APP CONFIGURATION
ENV PATH /home/docker/files/bin:$PATH

# Service Initialization
# Service Exposure

# Clean up APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

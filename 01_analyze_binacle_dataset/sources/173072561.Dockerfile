# use 12.04 precise (https://github.com/docker/docker/issues/5899)
FROM phusion/baseimage:0.9.9
MAINTAINER Arve Seljebu arve.seljebu@gmail.com

# no ssh
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# environment
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

# use baseimage init system
CMD ["/sbin/my_init"]

# install netatalk 3 from ppa
RUN \
    echo "deb http://ppa.launchpad.net/ali-asad-lotia/netatalk-stable/ubuntu precise main" > /etc/apt/sources.list.d/netatalk3.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AC857259 && \
    apt-get update && \
    apt-get install -y --no-install-recommends netatalk avahi-daemon

# clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add user
RUN useradd --home /backup -m timemachine
RUN echo timemachine:timemachine | chpasswd 

# time machine volume
VOLUME /backup

# port
EXPOSE 548

# afp config
ADD afp.conf /etc/netatalk/afp.conf

# add init and services
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/

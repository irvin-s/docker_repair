FROM phusion/baseimage:0.9.15
MAINTAINER Cyrill Schumacher <cyrill@zookal.com>
ENV HOME /root
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# npStorage Container n=nginx p=php Storage

RUN mkdir /etc/service/bootstorage
ADD boot.sh /etc/service/bootstorage/run
RUN chmod 700 /etc/service/bootstorage/run

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

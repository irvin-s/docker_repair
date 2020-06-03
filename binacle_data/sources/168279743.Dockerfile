FROM phusion/baseimage:0.9.15
MAINTAINER Cyrill Schumacher <cyrill@zookal.com>
ENV HOME /root
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get install -y python-setuptools nano mysql-client-5.5

# git is not needed here but included in the base docker image.
# RUN apt-get remove -y git

# forwards mail to mailcatcher or any other SMTP service
RUN apt-get install -y exim4

RUN echo "deb http://dl.hhvm.com/ubuntu trusty main" > /etc/apt/sources.list.d/hhvm.list && \
        apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes hhvm-fastcgi

RUN mkdir /etc/service/hhvm
ADD boot.sh /etc/service/hhvm/run
RUN chmod 700 /etc/service/hhvm/run

ADD . /configs

ADD cp /configs/config.hdf /etc/hhvm/config.hdf

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/log/hhvm

# Add VOLUMEs to allow backup of config
VOLUME  ["/etc/exim4/", "/var/log/hhvm"]

EXPOSE 9000

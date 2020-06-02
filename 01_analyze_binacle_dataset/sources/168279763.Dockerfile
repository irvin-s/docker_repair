FROM phusion/baseimage:0.9.15
MAINTAINER Cyrill Schumacher <cyrill@zookal.com>
ENV HOME /root
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# for http://ppa.launchpad.net trusty Release
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

# add php5.5 repository
RUN add-apt-repository -y ppa:ondrej/php5 > /dev/null 2>&1 # dirty fix for "invalid UTF-8 in string"
RUN apt-get update -y

# Basic Requirements
RUN apt-get install -y php5-fpm php5-mysql php5-curl php5-mcrypt php5-gd php5-oauth php5-redis php5-xdebug
RUN apt-get install -y php5-apcu
RUN apt-get install -y python-setuptools nano mysql-client-5.5

# git is not needed here but included in the base docker image.
# RUN apt-get remove -y git

# forwards mail to mailcatcher or any other SMTP service
RUN apt-get install -y exim4

RUN mkdir /etc/service/php5
ADD boot.sh /etc/service/php5/run
RUN chmod 700 /etc/service/php5/run

ADD . /configs

RUN cp -f /configs/php5/php-fpm.conf /etc/php5/fpm/php-fpm.conf
RUN cp -f /configs/php5/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf
RUN cp -f /configs/php5/php.ini /etc/php5/fpm/php.ini
RUN cp -f /configs/php5/mods-available/* /etc/php5/mods-available/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add VOLUMEs to allow backup of config
VOLUME  ["/etc/php5/fpm/", "/etc/exim4/"]

EXPOSE 9000

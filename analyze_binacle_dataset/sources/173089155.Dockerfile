# Bind
#
# A simple name server.

FROM phusion/baseimage:0.9.22
MAINTAINER CosmicQ <cosmicq@cosmicegg.net>

ENV HOME /root
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8

RUN ln -s -f /bin/true /usr/bin/chfn

# Install packages
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install bind9 wget
RUN echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
#RUN echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib" >> /etc/apt/sources.list
RUN echo "Acquire::GzipIndexes \"false\"; Acquire::CompressionTypes::Order:: \"gz\";" > /etc/apt/apt.conf.d/docker-gzip-indexes
RUN wget http://www.webmin.com/jcameron-key.asc && apt-key add jcameron-key.asc
RUN apt-get update
RUN apt-get -y install webmin && apt-get clean

ADD start_named.sh /etc/service/named/run
ADD start_webmin.sh /etc/service/webmin/run
ADD update_pass.sh /etc/my_init.d/01_update_pass.sh
ADD named.tar.gz /root/named
ADD webmin.tar.gz /root/webmin

EXPOSE 10000
EXPOSE 53
VOLUME ["/etc/bind","/var/lib/bind","/etc/webmin"]

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

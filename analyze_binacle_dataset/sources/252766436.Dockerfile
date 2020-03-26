# Use phusion/baseimage as base image. To make your builds  
# reproducible, make sure you lock down to a specific version, not  
# to `latest`! See  
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md  
# for a list of version numbers.  
FROM ubuntu:16.04  
MAINTAINER Lawrence Meckan <media@absalom.biz>  
  
# Tell the conatiner there is no tty  
ENV DEBIAN_FRONTEND noninteractive  
ENV HOME /root  
ENV DEFAULT_TIMEZONE Australia/Brisbane  
  
# Automatic choose local mirror for sources list  
COPY sources.list /etc/apt/sources.list  
  
# Update to latest packages and tidy up  
RUN apt-get update \  
&& apt-get -y install wget curl unzip git \  
&& apt-get -y upgrade \  
&& apt-get -y autoremove \  
&& apt-get -y clean \  
&& rm -rf /tmp/* /var/tmp/*  
  
ADD . /app  
  
RUN chmod +x /app/bin/*  
RUN ln -s /app/bin/set_timezone.sh /etc/my_init.d/00_set_timezone.sh


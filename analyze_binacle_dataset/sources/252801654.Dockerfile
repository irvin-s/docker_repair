####  
#  
# Dockerfile for building an baseimage as base for further images;  
#  
# this is a fork from https://github.com/phusion/baseimage-docker  
####  
#ubuntu:14.04  
FROM ubuntu:trusty-20170728  
MAINTAINER Henri Knochenhauer <henri.knochenhauer@eccenca.com>  
MAINTAINER René Pietzsch <rene.pietzsch@eccenca.com>  
  
ENV HOME /root  
RUN mkdir /build  
ADD . /build  
# Set the time zone  
RUN \  
mkdir /tz \  
&& mv /etc/timezone /tz/ \  
&& mv /etc/localtime /tz/ \  
&& ln -s /tz/timezone /etc/ \  
&& ln -s /tz/localtime /etc/ \  
&& echo "Europe/Berlin" > /etc/timezone \  
&& dpkg-reconfigure -f noninteractive tzdata  
  
RUN /build/prepare.sh && \  
/build/system_services.sh && \  
/build/utilities.sh && \  
/build/cleanup.sh  
  
# http://jaredmarkell.com/docker-and-locales/  
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
CMD ["/sbin/my_init"]  


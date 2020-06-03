FROM phusion/baseimage:0.9.18  
# Docker maintainer  
MAINTAINER Airlangga Cahya Utama <airlangga@durenworks.com>  
  
# Set correct environment variables.  
ENV DEBIAN_FRONTEND noninteractive  
ENV HOME /root  
  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
# Upgrade base image  
RUN apt-get update -yq && \  
apt-get upgrade -yq && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Update repository information  
RUN apt-get update -yq && \  
apt-get install -yq \  
nginx \  
php5-cli \  
php5-fpm \  
php5-json \  
php5-gd \  
php5-imagick \  
php5-intl \  
php5-mcrypt \  
php5-curl \  
php5-xdebug \  
php5-mysql \  
php5-sqlite \  
php5-memcached \  
php5-pgsql \  
php5-redis && \  
php5enmod mcrypt && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Copy config file  
COPY build /build  
RUN cp -R /build/etc/* /etc  
  
# Expose ports.  
EXPOSE 80  


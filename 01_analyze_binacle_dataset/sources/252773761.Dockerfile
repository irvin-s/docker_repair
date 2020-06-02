FROM php:7.1.7-apache  
MAINTAINER "Neil Zeng" neil.zeng@gmail.com  
ENV container docker  
  
# 在国内构建的话， 使用163镜像  
# COPY config/apt/sources.list /etc/apt/  
RUN apt-get update && \  
apt-get install -y git \  
zip \  
unzip \  
libzip-dev \  
libcurl4-openssl-dev \  
pkg-config \  
libssl-dev && \  
pecl install zip && \  
pecl install xdebug && \  
pecl install mongodb  
COPY config/php.ini /usr/local/etc/php/php.ini  
RUN rm -rf /var/www/.ssh


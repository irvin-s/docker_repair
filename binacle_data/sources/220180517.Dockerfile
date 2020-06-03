FROM ubuntu:14.04
MAINTAINER xm

ENV LANG C.UTF-8

RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/mirrors.163.com\/ubuntu\//g' /etc/apt/sources.list

RUN apt-get update -y
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install mysql-server
RUN apt-get -yqq install apache2
RUN apt-get -yqq install php5 libapache2-mod-php5
RUN apt-get install -yqq php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl

RUN sed -i 's/Options Indexes FollowSymLinks/Options None/' /etc/apache2/apache2.conf
RUN sed -i "s/;session.upload_progress.enabled = On/session.upload_progress.enabled = Off/g" /etc/php5/apache2/php.ini

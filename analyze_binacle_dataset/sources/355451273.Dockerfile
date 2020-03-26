FROM ubuntu:14.04

MAINTAINER Alex Vo <tuanmaster2012@gmail.com>

RUN apt-get update
RUN apt-get -y upgrade

# Install apache, PHP, and supplimentary programs. curl and lynx-cur are for debugging the container.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php5 php5-mysql php5-gd php5-mcrypt php5-curl php5-redis php5-memcached curl lynx-cur python-setuptools collectd vim python-pip

# Enable apache mods.
RUN a2enmod php5
RUN a2enmod rewrite

# Install supervisord
RUN easy_install supervisor

RUN sed -ie 's/memory_limit\ =\ 128M/memory_limit\ =\ 2G/g' /etc/php5/apache2/php.ini
RUN sed -ie 's/\;date\.timezone\ =/date\.timezone\ =\ Asia\/Ho_Chi_Minh/g' /etc/php5/apache2/php.ini
RUN sed -ie 's/upload_max_filesize\ =\ 2M/upload_max_filesize\ =\ 200M/g' /etc/php5/apache2/php.ini
RUN sed -ie 's/post_max_size\ =\ 8M/post_max_size\ =\ 200M/g' /etc/php5/apache2/php.ini

#**********************************
#* Override Enabled ENV Variables *
#**********************************
ENV APP_ROOTURL localhost
ENV MYSQL_SERVER localhost
ENV MYSQL_DATABASE test
ENV MYSQL_USERNAME root
ENV MYSQL_PASSWORD root

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80 8125

# Copy site into place.
ADD www /var/www/site

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf
ADD start.sh /start.sh
ADD foreground.sh /etc/apache2/foreground.sh

# Enable mod_expires
RUN cp /etc/apache2/mods-available/expires.load /etc/apache2/mods-enabled/

# supervisord config
ADD supervisord.conf /etc/supervisord.conf

# copy all collected plugin config
ADD collectd-config.conf.tpl /etc/collectd/configs/collectd-config.conf.tpl

RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh
RUN mkdir /var/log/supervisor/
RUN pip install envtpl

# By default, run start.sh script
CMD ["/bin/bash", "/start.sh"]

FROM tianon/debian:jessie
MAINTAINER Matthias Kadenbach <matthias.kadenbach@gmail.com>

RUN apt-get update
RUN apt-get --force-yes -y install apache2 apache2-mpm-worker

RUN a2enmod proxy
RUN a2enmod proxy_fcgi
RUN a2enmod vhost_alias
RUN a2enmod rewrite
RUN a2enmod macro

RUN a2dissite 000-default.conf

ADD 001-multi-virtualhosts.conf /etc/apache2/sites-available/001-multi-virtualhosts.conf
RUN a2ensite 001-multi-virtualhosts.conf

ADD servername.conf /etc/apache2/conf-available/servername.conf
RUN a2enconf servername.conf

ADD php-macros.conf /etc/apache2/conf-available/php-macros.conf
RUN a2enconf php-macros.conf

# add start script
ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# bind volumes
VOLUME ["/www"]

# expose ports
EXPOSE 80

# run command
CMD ["start.sh"]
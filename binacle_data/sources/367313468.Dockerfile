FROM ubuntu:trusty
MAINTAINER Karen Baker 

RUN echo "Heavily copied from Alan Kent - https://github.com/alankent/docker-magento2-demo-apache"

# Get Apache, mysql client, PHP etc (subset of a full LAMP stack - no MySQL server)
RUN apt-get update && apt-get install -y apache2 mysql-client php5 php5-curl php5-mcrypt php5-gd php5-mysql php5-intl curl git php5-xsl

# mcrypt.ini appears to be missing from apt-get install. Needed for PHP mcrypt library to be enabled.
ADD files/config/20-mcrypt.ini /etc/php5/cli/conf.d/20-mcrypt.ini
ADD files/config/20-mcrypt.ini /etc/php5/apache2/conf.d/20-mcrypt.ini

# Environment variables from /etc/apache2/apache2.conf
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid

# Enable Apache rewrite module
RUN a2enmod rewrite

# Add the Apache virtual host file
ADD files/config/apache_default_vhost /etc/apache2/sites-enabled/magento2.conf
RUN rm -f /etc/apache2/sites-enabled/000-default.conf

# Add the MySQL client configuration file (no server settings)
ADD files/config/my.cnf /etc/mysql/my.cnf

# Install Magento 2
RUN mkdir /var/www/magento2
ADD files/scripts/install-magento2.sh /var/www/install-magento2.sh
RUN bash -x /var/www/install-magento2.sh

# Expose the web server port
EXPOSE 80

# Start up the Apache server
ADD files/scripts/runserver.sh /usr/local/bin/runserver.sh
RUN chmod +x /usr/local/bin/runserver.sh
ENTRYPOINT ["bash", "-c"]
CMD ["/usr/local/bin/runserver.sh"]

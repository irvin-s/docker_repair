# MySQL Server with Apache and phpmyadmin
#
# VERSION               0.0.1

FROM     ubuntu:latest
MAINTAINER Jonas Colmsjö "jonas@gizur.com"

RUN echo "export HOME=/root" >> /root/.profile

RUN apt-get update
RUN apt-get install -y wget nano curl git


#
# Install supervisord (used to handle processes)
#

RUN apt-get install -y supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf


#
# Change PHP version
#

RUN apt-get update
RUN curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
RUN chmod +x phpbrew
RUN mv phpbrew /usr/bin/phpbrew
RUN sudo apt-get install -y libxml2-dev libbz2-dev libmcrypt-dev libxslt1-dev php-pear libssl-dev libsslcommon2-dev libreadline-dev make
RUN phpbrew install 5.3.28 +default+openssl
RUN phpbrew init
#RUN echo "source ~/.phpbrew/bashrc" >> ~/.bashrc
#RUN phpbrew use php-5.3.28



#
# Install Apache and PHP
#

RUN apt-get install -y apache2 php5 php5-curl php5-mysql php5-mcrypt php5-gd php5-imap
RUN a2enmod rewrite
RUN a2enmod status
RUN php5enmod imap
ADD ./etc-apache2-mods-available-status.conf /etc/apache2/mods-available/status.conf
ADD ./etc-php5-apache2-php.ini /etc/php5/apache2/php.ini
RUN rm /var/www/html/index.html
RUN echo "<?php\nphpinfo();\n " > /var/www/html/info.php

# Install phpMyAdmin
ADD ./src-phpmyadmin/phpMyAdmin-4.0.8-all-languages.tar.gz /var/www/html/
ADD ./src-phpmyadmin/config.inc.php /var/www/html/phpMyAdmin-4.0.8-all-languages/config.inc.php


#
# Install MySQL
#

# Bundle everything
ADD ./src-mysql /src-mysql

# Install MySQL server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && apt-get clean && rm -rf /var/lib/apt/lists/*

# Fix configuration
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Setup admin user and load data
RUN /src-mysql/mysql-setup.sh

#
# Start apache and mysql using supervisord
#

# Fix permissions
RUN chown -R www-data:www-data /var/www/html


ADD ./start.sh /

EXPOSE 3306 80 443
CMD ["/start.sh"]

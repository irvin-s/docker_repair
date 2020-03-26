FROM ubuntu:14.04
MAINTAINER Alfredo Amatriain <geralt@gmail.com>

# Install packages
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libapache2-mod-php5
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-mysql 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install pwgen 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php-apc
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-gd
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-mcrypt

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Add MySQL utils
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD create_mysql_prestashop_user.sh /create_mysql_prestashop_user.sh
ADD import_sql.sh /import_sql.sh
ADD create_db.sh /create_db.sh
RUN chmod 755 /*.sh

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Copy prestashop app to /var/www/html folder (default apache web app)
RUN rm -rf /var/www/html
ADD prestashop /var/www/html
RUN chmod -R 777 /var/www/html

# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql"]

# Add volumes for Apache
VOLUME  ["/var/log/apache2", "/var/www/html"]

# Default database passwords for admin and prestashop users
ENV MYSQL_ADMIN_PASS admin
ENV MYSQL_PRESTASHOP_PASS prestashop

EXPOSE 80 3306
CMD ["/run.sh"]

FROM ubuntu:14.04
MAINTAINER Brad Parker <brad@parker1723.com>
RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql  php5-ldap unzip

# setup hackazon
RUN easy_install supervisor
ADD ./scripts/start.sh /start.sh
ADD ./scripts/passwordHash.php /passwordHash.php
ADD ./scripts/foreground.sh /etc/apache2/foreground.sh
ADD ./configs/supervisord.conf /etc/supervisord.conf
ADD ./configs/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN rm -rf /var/www/
ADD https://github.com/rapid7/hackazon/archive/master.zip /hackazon-master.zip
RUN unzip /hackazon-master.zip -d hackazon
RUN mkdir /var/www/
RUN mv /hackazon/hackazon-master/ /var/www/hackazon
RUN cp /var/www/hackazon/assets/config/db.sample.php /var/www/hackazon/assets/config/db.php
RUN cp /var/www/hackazon/assets/config/email.sample.php /var/www/hackazon/assets/config/email.php
ADD ./configs/parameters.php /var/www/hackazon/assets/config/parameters.php
ADD ./configs/rest.php /var/www/hackazon/assets/config/rest.php
ADD ./configs/createdb.sql /var/www/hackazon/database/createdb.sql
RUN chown -R www-data:www-data /var/www/
RUN chown -R www-data:www-data /var/www/hackazon/web/products_pictures/
RUN chown -R www-data:www-data /var/www/hackazon/web/upload
RUN chown -R www-data:www-data /var/www/hackazon/assets/config
RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh
RUN a2enmod rewrite 
RUN mkdir /var/log/supervisor/

EXPOSE 80
CMD ["/bin/bash", "/start.sh"]
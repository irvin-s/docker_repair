# openphoto
FROM tutum/apache-php:latest

MAINTAINER Tim Petter <tim@timpetter.de>

# ubdate first
RUN apt-get update --assume-yes --quiet

# install some basic tools
RUN apt-get install --assume-yes --quiet curl wget

# install php
RUN apt-get install --assume-yes --quiet apache2 mysql-client php5 libapache2-mod-php5 php5-curl curl php5-gd php5-mcrypt php5-mysql php-pear php-apc php5-dev php5-imagick exiftran

# apt get cleanup
RUN apt-get clean

# configuration for invoice ninja
RUN php5enmod mcrypt
RUN a2enmod rewrite
RUN a2enmod deflate
RUN a2enmod expires
RUN a2enmod headers
RUN rm -fr /app

# add openphoto files
RUN mkdir /var/www/openphoto/
ADD openphoto /var/www/openphoto

RUN mkdir /var/www/openphoto/src/userdata
RUN chown www-data:www-data /var/www/openphoto/src/userdata

RUN mkdir /var/www/openphoto/src/html/assets/cache
RUN chown www-data:www-data /var/www/openphoto/src/html/assets/cache

RUN mkdir /var/www/openphoto/src/html/photos
RUN chown www-data:www-data /var/www/openphoto/src/html/photos

RUN sed -e 's/file_uploads.*/file_uploads = On/g' -e 's/upload_max_filesize.*/upload_max_filesize = 16M/g' -e 's/post_max_size.*/post_max_size = 16M/g' /etc/php5/apache2/php.ini > /etc/php5/apache2/php.ini.tmp
RUN mv /etc/php5/apache2/php.ini.tmp /etc/php5/apache2/php.ini

# add files
ADD docker-apache.conf /etc/apache2/sites-enabled/000-default.conf
ADD run-openphoto.sh /run-openphoto.sh

EXPOSE 80
CMD ["/run-openphoto.sh"]
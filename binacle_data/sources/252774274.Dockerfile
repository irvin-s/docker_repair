FROM php:5-apache  
MAINTAINER Attila Szeremi <attila+webdev@szeremi.com>  
WORKDIR /var/www  
RUN cd /var/www  
  
# This includes the docker-php-pecl-install executable  
COPY bin/docker-php-pecl-install /usr/local/bin/  
  
# PHP extensions  
RUN docker-php-ext-install mysqli  
  
COPY . .  
  
COPY config/docker/apache.conf /etc/apache2/sites-available/000-default.conf  
  
RUN a2enmod rewrite  
  
RUN mkdir -p phpBB/cache  
RUN chmod a+rwx phpBB/cache  
  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  
  


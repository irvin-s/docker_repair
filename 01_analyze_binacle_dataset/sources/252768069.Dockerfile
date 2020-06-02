FROM php:5.6-apache  
MAINTAINER Adam Yeats <ay@commonhq.com>  
  
# install Composer  
RUN curl -sS https://getcomposer.org/installer | php  
RUN chmod +x composer.phar  
RUN mv composer.phar /usr/local/bin/composer  
  
RUN apt-get update && apt-get install -yq \  
build-essential \  
git \  
zlib1g-dev \  
libicu-dev \  
libcurl4-gnutls-dev \  
libpng-dev \  
&& apt-get clean  
  
# drop to a seperate RUN statement to avoid a funky docker bug  
RUN rm -rf /var/lib/apt/lists/  
  
RUN docker-php-ext-install zip mysql mysqli intl curl gd  
  
RUN a2enmod rewrite  
  
COPY apache/mothership.conf /etc/apache2/sites-enabled/mothership.conf  
  
# Copy init scripts and custom .htaccess  
COPY docker-entrypoint.sh /entrypoint.sh  
COPY makedb.php /makedb.php  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["apache2-foreground"]  
  


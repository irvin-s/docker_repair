FROM php:5.6-apache  
  
RUN apt-get update && apt-get install -y \  
libmcrypt-dev \  
libldap2-dev \  
&& docker-php-ext-install mcrypt \  
&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \  
&& docker-php-ext-install ldap  
  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["apache2-foreground"]  
  
COPY . /var/www/html  


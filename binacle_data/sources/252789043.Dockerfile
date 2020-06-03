FROM drupalwxt/site-pco-cities:latest  
MAINTAINER William Hearn <sylus1984@gmail.com>  
  
COPY php.ini /usr/local/etc/php/php.ini  
  
## START CI  
# Install composer dependencies with dev.  
RUN composer install --prefer-dist --no-interaction  
  
RUN ln -s /var/www/vendor/bin/behat /usr/local/bin/behat && \  
ln -s /var/www/vendor/bin/phpcs /usr/local/bin/phpcs && \  
ln -s /var/www/vendor/bin/phpmd /usr/local/bin/phpmd && \  
ln -s /var/www/vendor/bin/phpunit /usr/local/bin/phpunit && \  
ln -s /var/www/vendor/bin/drupal /usr/local/bin/drupal  
  
## END CI  
  
RUN php -r "opcache_reset();"  


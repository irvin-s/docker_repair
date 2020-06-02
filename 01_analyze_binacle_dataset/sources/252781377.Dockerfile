FROM banderson/drupal  
  
MAINTAINER bander2.imda@gmail.com  
  
COPY drupal/load.environment.php /var/www/drupal/load.environment.php  
COPY drupal/web/autoload.php /var/www/drupal/web/autoload.php  
COPY drupal/web/modules/custom /var/www/drupal/web/modules/custom  
COPY drupal/scripts /var/www/drupal/scripts  
COPY drupal/drush /var/www/drupal/drush  
COPY drupal/composer.json /var/www/drupal/composer.json  
COPY drupal/composer.lock /var/www/drupal/composer.lock  
COPY drupal/config /var/www/drupal/config  
  
RUN composer install -d /var/www/drupal  
  
COPY docker/web/entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  


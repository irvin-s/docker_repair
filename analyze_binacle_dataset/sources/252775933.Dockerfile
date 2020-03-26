FROM registry.gitlab.com/janpoboril/drupal-composer-docker:7.1-apache  
  
  
COPY src /var/www/drupal  
  
  
  
RUN chown -R www-data /var/www  
  
USER www-data  
RUN chmod +w /var/www/drupal/web/sites/default  
RUN composer install  
  
USER root


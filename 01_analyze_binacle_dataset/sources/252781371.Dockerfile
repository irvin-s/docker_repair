FROM drupal:fpm  
  
MAINTAINER bander2.imda@gmail.com  
LABEL version="1.0.0"  
  
RUN apt-get update && apt-get install -y wget git \  
&& wget https://getcomposer.org/installer \  
&& php ./installer \  
&& ./composer.phar require drupal/console \  
&& rm ./composer.phar ./installer  
  
CMD ["/var/www/html/vendor/bin/drupal"]  


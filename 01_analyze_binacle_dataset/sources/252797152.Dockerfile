# Latest Ubuntu LTS  
FROM cloudposse/apache-php-fpm  
  
MAINTAINER Erik Osterman "e@osterman.com"  
ADD conf-available/ /etc/apache2/conf-available/  
  
# Activate modules  
RUN a2enmod vhost_alias  
  
# Activate configurations  
RUN a2enconf dynamic-vhost  
  


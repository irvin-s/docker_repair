FROM drupal:fpm  
  
MAINTAINER brendan_anderson@hcpss.org  
LABEL vendor="Howard County Public School System"  
LABEL version="1.0.0"  
  
RUN apt-get update && apt-get install -y wget git mysql-client \  
&& wget https://getcomposer.org/installer \  
&& php ./installer \  
&& ./composer.phar global require drush/drush \  
&& rm ./composer.phar ./installer \  
&& ln -s /root/.composer/vendor/bin/drush /drush  
  
CMD ["/drush"]  


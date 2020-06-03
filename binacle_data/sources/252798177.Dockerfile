FROM delamaison/php-fpm  
  
MAINTAINER Rémi FUSSIEN <remi.fussien@elbee.fr>  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends git vim \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& rm -rf /tmp/* \  
# composer  
&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \  
&& php composer-setup.php --install-dir=/bin --filename=composer \  
&& php -r "unlink('composer-setup.php');"  


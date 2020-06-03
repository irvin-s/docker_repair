FROM drupal:fpm  
  
MAINTAINER brendan_anderson@hcpss.org  
LABEL vendor="Howard County Public School System"  
LABEL version="1.0.0"  
  
RUN apt-get update && apt-get install -y wget git \  
&& wget https://getcomposer.org/installer \  
&& php ./installer \  
&& rm ./installer \  
&& mv ./composer.phar /usr/local/bin/composer  
  
CMD ["/usr/local/bin/composer"]  


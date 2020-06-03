# A php fpm Docker image with commonly used modules installed.  
FROM php:5.6-fpm  
  
MAINTAINER Hong Xu <hong@topbug.net>  
  
COPY php_fpm_run.sh /usr/local/bin/php_fpm_run.sh  
  
CMD ["/usr/local/bin/php_fpm_run.sh"]  


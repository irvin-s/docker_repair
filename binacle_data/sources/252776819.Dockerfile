FROM php:apache  
MAINTAINER Catalin Ciocov catalin.ciocov@gmail.com  
  
# enable the apache modules we need:  
RUN a2enmod ext_filter vhost_alias  
  
# copy apache conf files:  
COPY *.conf /etc/apache2/conf-enabled/  
  
# livereload filter:  
COPY livereload.php /usr/local/bin/  


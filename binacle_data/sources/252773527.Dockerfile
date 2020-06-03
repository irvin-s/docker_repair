FROM billwilliam/apache-php:pgsql  
  
MAINTAINER Billaud <william.billaud@isen.yncrea.fr>  
  
RUN apt-get update \  
&& apt-get install -y libzip-dev \  
&& pecl install zip && echo "extension=zip.so">> /usr/local/etc/php/php.ini \  
&& service apache2 restart  


FROM wordpress:fpm  
MAINTAINER Marc Richter <richter_marc@gmx.net>  
RUN apt-get update ; apt-get dist-upgrade -y  
RUN docker-php-ext-install mbstring  


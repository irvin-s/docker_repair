FROM richarvey/nginx-php-fpm:1.3.5  
MAINTAINER Henri LARGET<henri.larget@aboutgoods.net>  
RUN set -ex \  
&& apk --no-cache add \  
postgresql-dev  
RUN docker-php-ext-install pdo_pgsql  
  
CMD ["/start.sh"]  


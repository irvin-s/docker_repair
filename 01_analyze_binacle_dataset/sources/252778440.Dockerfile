FROM tehraven/dark-os:latest  
MAINTAINER Alex Cameli "https://github.com/arcameli"  
# BUILDS arcameli/coordinatesocial  
ADD root /  
COPY web /var/www  
COPY composer.json /var/www/composer.json  
WORKDIR /var/www  
RUN composer install  
RUN rm -f /var/www/composer.json  
  
# Maybe?  
# VOLUME ["/var/cache/nginx"]  
EXPOSE 80


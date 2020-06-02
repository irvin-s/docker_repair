FROM matriphe/alpine-php:cli-5.6  
MAINTAINER Akhyar Amarullah <akhyrul@gmail.com>  
  
RUN apk update && \  
apk add php-intl && \  
rm -rf /var/cache/apk/*  
  
VOLUME /books  
COPY cops/ /www/  
COPY config_local.php /www/config_local.php  
  
EXPOSE 9000  
CMD php -S 0.0.0.0:9000  


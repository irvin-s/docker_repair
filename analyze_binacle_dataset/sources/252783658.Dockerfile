FROM wordpress:fpm  
  
MAINTAINER Marcin Ochab <marcin.ochab@gmail.com>  
  
RUN apt-get update && apt-get install -y ssmtp && rm -r /var/lib/apt/lists/*  
  
VOLUME /etc/ssmtp  
  
COPY ssmtp.conf /etc/ssmtp/ssmtp.conf  
COPY php-smtp.ini /usr/local/etc/php/conf.d/php-smtp.ini  
COPY docker-entrypoint-pre.sh /docker-entrypoint-pre.sh  
  
ENTRYPOINT ["/docker-entrypoint-pre.sh"]  
CMD ["php-fpm"]


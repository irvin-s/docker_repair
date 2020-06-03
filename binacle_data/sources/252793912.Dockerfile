FROM choobs/php:5.6-cli  
MAINTAINER Erik DeLamarter <erik.delamarter@choobs.com>  
  
RUN apk add --update \  
php-apcu \  
php-pdo_mysql \  
&& rm -rf /var/cache/apk/*  
  
RUN mkdir /www  
  
VOLUME /www  
  
COPY phps /bin/  
COPY router.php /  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
EXPOSE 8080  
CMD ["phps"]  


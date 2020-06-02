FROM bakerdist/magento2-php:7.1-cli  
  
USER root  
  
RUN apk --update add \--no-cache \  
tini git \  
&& mkdir -p /app \  
&& chown www-data:www-data /app  
  
COPY \--from=composer:1.5 /usr/bin/composer /usr/bin/composer  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
  
WORKDIR /app  
  
USER www-data  
  
RUN composer global require hirak/prestissimo  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
CMD ["composer"]  


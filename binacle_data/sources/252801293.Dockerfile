FROM dynamicflow/php:latest  
MAINTAINER Alessandro Oliveira <alessandro@dynamicflow.com.br>  
  
COPY website /var/www/lopesmogi/  
COPY docker/web/lopesmogi.conf /etc/apache2/sites-enabled  
COPY docker/web/php.ini /etc/php/7.0/apache2/php.ini  
COPY docker/web/environment.conf /var/www/lopesmogi/.env  
COPY docker/web/database.php /var/www/lopesmogi/config/database.php  
#COPY docker/ssl /var/www/lopesmogi/ssl  
COPY docker/web/docker-entrypoint.sh /usr/local/bin  
RUN chmod +x /usr/local/bin/docker-entrypoint.sh  
  
VOLUME [ /var/www/lopesmogi/public/static/uploads ]  
VOLUME [ /var/www/lopesmogi/storage ]  
VOLUME [ /var/log/apache2 ]  
  
WORKDIR /var/www/lopesmogi  
  
ENTRYPOINT [ "docker-entrypoint.sh" ]


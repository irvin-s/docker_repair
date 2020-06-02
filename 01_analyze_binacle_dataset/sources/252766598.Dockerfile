FROM nextcloud:13-fpm-alpine  
  
COPY redis.config.php /usr/src/nextcloud/config/redis.config.php  


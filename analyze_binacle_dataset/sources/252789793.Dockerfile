FROM php:7.2.2-fpm-alpine3.7  
  
MAINTAINER dylanchu  
  
COPY php.ini /usr/local/etc/php/conf.d/php.ini  
  
RUN apk add --no-cache tzdata && \  
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \  
rm /usr/share/zoneinfo/ -rf && \  
mkdir -p /usr/share/zoneinfo/Asia/ && \  
cp /etc/localtime /usr/share/zoneinfo/Asia/Shanghai && \  
docker-php-ext-install pdo_mysql  
  
EXPOSE 9000  
  
CMD ["php-fpm"]  


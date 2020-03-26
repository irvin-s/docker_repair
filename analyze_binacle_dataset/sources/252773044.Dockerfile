FROM bettermood/php:latest  
  
RUN pecl install xdebug  
RUN docker-php-ext-enable xdebug  
  
ARG XDEBUGCONF=$PHP_INI_DIR/conf.d/xdebug.ini  
  
COPY ./xdebug.ini $XDEBUGCONF  
  
ARG XDEBUG_IDE_KEY="bettermood"  
RUN /sbin/ip route | awk '/default/ { print $3 }' >> /tmp/hostip  
  
RUN sed -i -e 's/<<XDEBUG_IDE_KEY>>/'${XDEBUG_IDE_KEY}'/g' \  
-e 's/<<HOST_IP>>/'$(cat /tmp/hostip)'/g' \  
$XDEBUGCONF


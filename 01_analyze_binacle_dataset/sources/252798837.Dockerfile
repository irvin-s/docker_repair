FROM php:alpine  
MAINTAINER "VAILLANT Jérémy" <vaillant.jeremy@dev-crea.com>  
  
ENV PROJECT /var/www/html  
  
# Prepare system  
RUN apk update \  
&& apk upgrade \  
&& apk add --no-cache sqlite git openjdk8-jre openrc bash \  
&& rm -rf /var/cache/apk/*  
  
# Download project  
RUN git clone https://github.com/kiswa/TaskBoard $PROJECT  
  
WORKDIR $PROJECT  
  
# Build project  
RUN php build/composer.phar update  
RUN php build/composer.phar install  
RUN bash ./build/build-all  
  
# Configure project  
RUN chmod -R +w $PROJECT/api/  
RUN chown -R www-data:www-data $PROJECT/  
  
# Cleanning system  
RUN apk del git openjdk8-jre openrc bash  
  
# Start instance to service  
CMD ["php", "-S", "0.0.0.0:8080", "devrouter.php"]  


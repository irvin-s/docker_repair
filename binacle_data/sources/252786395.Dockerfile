FROM dockenizer/dev  
MAINTAINER Jacques Moati <jacques@moati.net>  
  
RUN apk --update add make && \  
rm -rf /var/cache/apk/*  
  
RUN docker-php-ext-enable xdebug && \  
rm -rf /var/cache/apk/*  


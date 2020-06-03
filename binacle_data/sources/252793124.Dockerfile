FROM dankempster/php:fpm  
MAINTAINER Dan Kempster <dev@dankempster.co.uk>  
  
RUN mkdir -p /symfony/cache; \  
mkdir -p /symfony/vendor; \  
\  
chown -R www-data:www-data /symfony; \  
chmod -R 2775 /symfony;  
  
ENV DOCKER=1 \  
COMPOSER_VENDOR_DIR=/symfony/vendor \  
PATH=/symfony/vendor/bin:$PATH  
  
VOLUME ["/symfony/cache", "/symfony/vendor"]  


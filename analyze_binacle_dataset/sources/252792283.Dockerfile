FROM cheeryfella/php-fpm:latest  
  
MAINTAINER CheeryFella <cheeryfella@gmail.com>  
  
RUN set -ex \  
&& apk add --no-cache --virtual .build-deps \  
wget \  
&& wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \  
&& chmod +x phpcs.phar \  
&& mv phpcs.phar /usr/bin/phpcs \  
&& apk del .build-deps \  
&& rm -rf /var/cache/apk/*mkdir \  
&& mkdir /code \  
&& phpcs --config-set default_standard PSR2  
  
WORKDIR /code  
  
ENTRYPOINT ["phpcs"]  
  
CMD ["--help"]  


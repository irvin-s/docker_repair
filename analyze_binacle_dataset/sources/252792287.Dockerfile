FROM cheeryfella/xdebug:latest  
  
MAINTAINER CheeryFella <cheeryfella@gmail.com>  
  
RUN set -ex \  
&& apk add --no-cache --virtual .build-deps \  
wget \  
&& wget https://phar.phpunit.de/phpunit.phar \  
&& chmod +x phpunit.phar \  
&& mv phpunit.phar /usr/bin/phpunit \  
&& apk del .build-deps \  
&& rm -rf /var/cache/apk/*  
  
RUN mkdir /code  
WORKDIR /code  
  
ENTRYPOINT ["phpunit"]  


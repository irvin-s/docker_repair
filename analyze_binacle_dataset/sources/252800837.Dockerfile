FROM dotronglong/php-alpine  
  
ADD https://phar.phpunit.de/phpcpd.phar /usr/local/bin/phpcpd  
RUN chmod +rx /usr/local/bin/phpcpd  
  
ENTRYPOINT ["phpcpd"]  


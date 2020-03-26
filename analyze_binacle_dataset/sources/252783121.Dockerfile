FROM php:5.6-cli  
  
MAINTAINER Thomas Krampl  
  
  
RUN cd /tmp && \  
curl http://get.sensiolabs.org/php-cs-fixer.phar -s -o php-cs-fixer && \  
chmod a+x php-cs-fixer && \  
mv php-cs-fixer /usr/local/bin/php-cs-fixer  
  
VOLUME /app  
  
WORKDIR /app  
  
CMD ["php-cs-fixer", "fix", "/app", "--dry-run", "--diff"]  


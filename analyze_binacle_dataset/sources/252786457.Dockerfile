FROM dockercraft/composer  
MAINTAINER Daniel <daniel@topdevbox.com>  
  
# How-To  
# Local Build: docker build -t phpstan .  
# Local Run: docker run -it phpstan phpstan -V  
  
RUN apk add --update \  
php7-tokenizer \  
php7-iconv \  
&& rm -rf /var/cache/apk/*  
  
RUN composer global require "phpstan/phpstan=0.9.2" \  
&& ln -s /root/.composer/vendor/phpstan/phpstan/bin/phpstan /bin/phpstan  
  


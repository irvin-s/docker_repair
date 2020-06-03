FROM php:5.6.2-cli  
MAINTAINER Denis Uraganov <github@uraganov.net>  
  
RUN echo "date.timezone = UTC" >> /usr/local/etc/php/php.ini  
  
RUN curl -O http://phpab.net/phpab-1.16.0.phar  
RUN mv phpab-*.phar /usr/local/bin/phpab  
RUN chmod +x /usr/local/bin/phpab  
RUN phpab -v  
  
RUN mkdir -p /workspace  
WORKDIR /workspace  
  
ENTRYPOINT ["phpab"]


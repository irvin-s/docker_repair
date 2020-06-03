FROM php:5.6.2-cli  
MAINTAINER Denis Uraganov <github@uraganov.net>  
  
RUN apt-get update && apt-get install -y libbz2-dev  
RUN docker-php-ext-install bz2  
RUN echo "date.timezone = UTC" >> /usr/local/etc/php/php.ini  
  
RUN curl -O http://static.pdepend.org/php/latest/pdepend.phar  
RUN mv pdepend.phar /usr/local/bin/pdepend  
RUN chmod +x /usr/local/bin/pdepend  
  
RUN mkdir -p /workspace  
WORKDIR /workspace  
  
ENTRYPOINT ["pdepend"]


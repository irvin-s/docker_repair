FROM php:5.6-cli  
  
MAINTAINER Centric Web Estate <docker@cwe.space>  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y zlib1g-dev git && \  
rm -r /var/lib/apt/lists/*  
  
RUN curl -sS https://getcomposer.org/installer | \  
php -- --install-dir=/usr/local/bin --filename=composer && \  
chmod +x /usr/local/bin/composer  
  
ENV COMPOSER_HOME "/root/.composer"  
RUN php --version && \  
composer --version  
  
CMD ["-"]  
ENTRYPOINT ["composer", "--ansi"]  


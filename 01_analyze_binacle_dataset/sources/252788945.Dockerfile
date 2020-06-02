FROM php:7.1-alpine  
  
RUN apk add --update wget openssh  
  
ENV COMPOSER_ALLOW_SUPERUSER=true  
  
RUN wget http://deployer.org/deployer.phar && \  
mv deployer.phar /usr/local/bin/dep && \  
chmod +x /usr/local/bin/dep && \  
wget https://getcomposer.org/composer.phar && \  
mv composer.phar /usr/local/bin/composer && \  
chmod +x /usr/local/bin/composer && \  
composer require deployer/recipes --dev && \  
apk del wget && \  
rm -rf /var/cache/apk/*  
  
WORKDIR /app  
ENTRYPOINT ["/usr/local/bin/dep"]


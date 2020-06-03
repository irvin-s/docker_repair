FROM composer:latest  
  
RUN composer global require "hirak/prestissimo:^0.3"  
RUN composer global require fxp/composer-asset-plugin


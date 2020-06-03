FROM php:7-cli  
MAINTAINER Alexis Vincent <alexis@alexisvincent.io>  
  
# Install modules  
RUN apt-get update && apt-get install -y zlib1g-dev libpq-dev \  
&& rm -rf /var/lib/apt/lists/* \  
&& docker-php-ext-install mbstring pdo pdo_mysql pdo_pgsql zip  


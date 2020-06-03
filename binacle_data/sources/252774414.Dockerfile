FROM php:5-fpm  
RUN apt-get update && apt-get upgrade -y ssmtp && rm -rf /var/lib/apt/lists/*  


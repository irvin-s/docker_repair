FROM php:5-apache  
  
# Enable the rewrite module  
RUN a2enmod rewrite  
  
# Install msmtp to enable sending mail  
RUN apt-get update && apt-get install -y msmtp msmtp-mta \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /var/www/html  
  


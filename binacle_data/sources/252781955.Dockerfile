FROM richarvey/nginx-php-fpm:latest  
MAINTAINER Christopher Petty <Docker@chriswastaken.com>  
  
ENV WEBROOT /var/www/osvm_html  
  
#clear existing page.  
RUN rm -rf /var/www/html/*  
  
# Copy project  
COPY ./data /var/www/osvm_html  
  
# Open port 80  
EXPOSE 80  


FROM webdevops/php-apache  
RUN apt-get update && apt-get install -y \  
php7.0-snmp \  
&& rm -rf /var/lib/docker images  
  
RUN echo "wersja 666 <?php phpinfo() ?>" > /app/index.php  


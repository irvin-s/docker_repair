FROM debian:jessie  
RUN apt-get update && apt-get install -y --no-install-recommends \  
apache2 \  
php5 \  
php5-curl \  
php5-gd \  
php5-imagick \  
php5-mcrypt \  
php5-memcached \  
php5-redis \  
php5-mysql \  
unzip && \  
rm -rf /var/lib/apt/lists/*  
  
RUN service apache2 stop  
  
## Enable apache mod  
RUN a2enmod headers && \  
a2enmod rewrite  
  
## Deploy config  
ADD apache2 /etc/apache2  
ADD php5 /etc/php5  
COPY apache2-foreground /usr/local/bin/  
  
RUN mkdir -p /opt/web/app/www && \  
echo -e "<?php\nphpinfo();" > /opt/web/app/www/index.php  
  
EXPOSE 80  
CMD ["/usr/local/bin/apache2-foreground"]  


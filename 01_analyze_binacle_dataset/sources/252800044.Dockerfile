FROM ubuntu:14.04  
VOLUME ["/var/www"]  
  
RUN apt-get update && \  
apt-get install -y \  
apache2 \  
php5 \  
php5-cli \  
libapache2-mod-php5 \  
php5-gd \  
php5-ldap \  
php5-mysql \  
php5-pgsql  
  
COPY apache_default /etc/apache2/sites-available/default.conf  
COPY run /usr/local/bin/run  
RUN chmod +x /usr/local/bin/run  
RUN a2enmod rewrite  
RUN a2dissite 000-default.conf  
RUN a2ensite default.conf  
  
EXPOSE 80  
CMD ["/usr/local/bin/run"]  


FROM achtachtel/debian-dotdeb:jessie  
  
MAINTAINER Marcel Brand <marcel.brand@achtachtel.de>  
  
# Update and install apache2 and php7.0  
RUN apt-get update && apt-get install -y \  
apache2 \  
php7.0 \  
&& apt-get clean  
  
RUN /usr/sbin/a2enmod ssl && \  
/usr/sbin/a2enmod rewrite  
  
EXPOSE 80  
EXPOSE 443  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


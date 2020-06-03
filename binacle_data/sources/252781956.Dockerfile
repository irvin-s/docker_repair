FROM debian:jessie  
MAINTAINER Christian Wagner chriswayg@gmail.com  
  
# Usage:  
# docker run -d --name=apache-php -p 8080:80 -p 8443:443 chriswayg/apache-php  
# webroot: /var/www/html/  
# Apache2 config: /etc/apache2/  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get -y install \  
apache2 \  
libapache2-mod-php5 \  
php5 && \  
apt-get clean && rm -r /var/lib/apt/lists/*  
  
# Apache + PHP requires preforking Apache for best results & enable Apache SSL  
# forward request and error logs to docker log collector  
RUN a2dismod mpm_event && \  
a2enmod mpm_prefork \  
ssl \  
rewrite && \  
a2ensite default-ssl && \  
ln -sf /dev/stdout /var/log/apache2/access.log && \  
ln -sf /dev/stderr /var/log/apache2/error.log  
  
WORKDIR /var/www/html  
  
COPY apache2-foreground /usr/local/bin/  
  
EXPOSE 80  
EXPOSE 443  
CMD ["apache2-foreground"]  


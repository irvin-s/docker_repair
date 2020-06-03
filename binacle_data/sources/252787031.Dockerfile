FROM alpine:latest  
  
MAINTAINER brainsam@yandex.ru  
  
RUN apk --update add \  
apache2 \  
php5-mysql \  
php5-gd \  
php5-zip \  
php5-mysqli \  
php5-dom \  
php5-iconv \  
php5-apache2 \  
php5-soap \  
php5-ldap \  
php5-mcrypt \  
graphviz \  
php5-cli \  
php5-json && \  
rm -f /var/cache/apk/* && \  
mkdir /run/apache2 && \  
chown apache:apache /run/apache2  
  
ENTRYPOINT ["/usr/sbin/httpd","-DFOREGROUND"]  


FROM alastairhm/alpine-lighttpd:latest  
MAINTAINER Alastair Montgomery <alastair@montgomery.me.uk>  
  
RUN apk --update add \  
php-common \  
php-iconv \  
php-json \  
php-gd \  
php-curl \  
php-xml \  
php-pgsql \  
php-imap \  
php-cgi \  
fcgi \  
php-pdo \  
php-pdo_pgsql \  
php-soap \  
php-xmlrpc \  
php-posix \  
php-mcrypt \  
php-gettext \  
php-ldap \  
php-ctype \  
php-dom \  
git && \  
rm -rf /var/cache/apk/*  
  
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf  
RUN mkdir -p /var/www2 && \  
git clone https://github.com/sn0opy/MPD-Webinterface.git && \  
mv MPD*/* /var/www2/ && \  
chown -R www-data. /var/www2/* && \  
rm -rf MPD* && \  
sed -i 's/localhost/icy/g' /var/www2/index.php && \  
mkdir -p /run/lighttpd/ && \  
chown www-data. /run/lighttpd/  
  
EXPOSE 80  
  
CMD php-fpm -D && lighttpd -D -f /etc/lighttpd/lighttpd.conf  
  


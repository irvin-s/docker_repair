FROM cloudycube/base-supervisor  
MAINTAINER Sascha Falk <sascha@falk-online.eu>  
  
# Update image and install additional packages  
RUN apt-get -y update && \  
apt-get -y install \  
nginx \  
php7.0-bcmath \  
php7.0-bz2 \  
php7.0-curl \  
php7.0-dba \  
php7.0-enchant \  
php7.0-fpm \  
php7.0-gd \  
php7.0-gmp \  
php7.0-imap \  
php7.0-intl \  
php7.0-json \  
php7.0-ldap \  
php7.0-mbstring \  
php7.0-mcrypt \  
php7.0-mysql \  
php7.0-odbc \  
php7.0-opcache \  
php7.0-pgsql \  
php7.0-pspell \  
php7.0-readline \  
php7.0-recode \  
php7.0-sqlite3 \  
php7.0-tidy \  
php7.0-xml \  
php7.0-xmlrpc \  
php7.0-xsl \  
php7.0-zip && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# Copy prepared files into the image  
COPY target /  
  
# Remove superfluous files and adjust ownership and permissions  
RUN \  
rm /var/www/html/index.nginx-debian.html && \  
chown -R www-data:www-data /var/www  
  
# Expose port 80 (HTTP) only  
# (SSL handling is done by an SSL termination proxy)  
EXPOSE 80  


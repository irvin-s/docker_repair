FROM janes/alpine-s6
MAINTAINER janes - https://github.com/hxer/alpine-apache

# Install apache, mysql, php5 and php extension
RUN apk add --update apache2 apache2-utils \
    mysql mysql-client \
    php5-apache2 php5-cli php5-phar php5-zlib php5-zip \
    php5-ctype php5-mysqli php5-xml php5-pdo_mysql php5-opcache \
    php5-pdo php5-json php5-curl php5-gd php5-mcrypt php5-openssl php5-dom

# configure apache
RUN sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf && \
    sed -i 's#ServerName www.example.com:80#\nServerName localhost:80#' /etc/apache2/httpd.conf
RUN mkdir -p /run/apache2 && \
    chown -R apache:apache /run/apache2

#configure mysql
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    mysql_install_db --user=mysql --verbose=1 --basedir=/usr --datadir=/var/lib/mysql --rpm > /dev/null

# Add the files
ADD root /

#VOLUME ["/var/www/localhost/htdocs"]

# Expose the ports for apache
EXPOSE 80 3306

FROM janes/alpine-apache
MAINTAINER janes - https://github.com/hxer/alpine-apache-fpm

# Install php5 adn php extension
RUN apk add --update php5-apache2 php5-cli php5-phar php5-zlib php5-zip \
    php5-ctype php5-mysqli php5-xml php5-pdo_mysql php5-opcache php5-pdo \
    php5-json php5-curl php5-gd php5-mcrypt php5-openssl php5-dom

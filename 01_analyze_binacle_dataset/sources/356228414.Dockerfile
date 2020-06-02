FROM php:5.6-fpm
# Install modules
RUN apt-get update && apt-get install -y \
        curl \
        git \
        php5-cli \
        php5-mcrypt \
        php5-gd \
        php5-xdebug \
        php5-curl \
        php5-mysql

RUN docker-php-ext-install bcmath
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install tokenizer

RUN apt-get install -y zlib1g-dev \
    && docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php 
RUN mv composer.phar /usr/local/bin/composer

# Possible values for docker-php-ext-install:
# bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd 
# gettext gmp hash iconv imap interbase intl json ldap mbstring mcrypt mssql 
# mysql mysqli oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird pdo_mysql 
# pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix pspell readline recode 
# reflection session shmop simplexml snmp soap sockets spl standard sybase_ct sysvmsg 
# sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip
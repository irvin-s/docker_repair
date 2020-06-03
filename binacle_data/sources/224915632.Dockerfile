FROM php:5.6-apache

MAINTAINER Amjad Afanah (amjad@dchq.io)

RUN apt-get update
RUN apt-get -y install php-pear php5-dev libmysqlclient15-dev libpq-dev
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql

COPY ./software /var/www/html/

# Oracle instantclient
COPY ./software/oracle/instantclient-basic-linux.x64-11.2.0.4.0.zip /tmp/instantclient-basic-linux.x64-11.2.0.4.0.zip
COPY ./software/oracle/instantclient-sdk-linux.x64-11.2.0.4.0.zip /tmp/instantclient-sdk-linux.x64-11.2.0.4.0.zip
COPY ./software/oracle/instantclient-sqlplus-linux.x64-11.2.0.4.0.zip /tmp/instantclient-sqlplus-linux.x64-11.2.0.4.0.zip
COPY ./software/oracle/tns.ora /etc/tns.ora

RUN apt-get install -y unzip

RUN unzip /tmp/instantclient-basic-linux.x64-11.2.0.4.0.zip -d /usr/local/
RUN unzip /tmp/instantclient-sdk-linux.x64-11.2.0.4.0.zip -d /usr/local/
RUN unzip /tmp/instantclient-sqlplus-linux.x64-11.2.0.4.0.zip -d /usr/local/
RUN ln -s /usr/local/instantclient_11_2 /usr/local/instantclient
RUN ln -s /usr/local/instantclient/libclntsh.so.11.1 /usr/local/instantclient/libclntsh.so
RUN ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus

RUN apt-get install libaio-dev -y

ENV LD_LIBRARY_PATH /usr/local/instantclient
ENV TNS_ADMIN       /usr/local/instantclient
ENV ORACLE_BASE     /usr/local/instantclient
ENV ORACLE_HOME     /usr/local/instantclient

RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8

RUN echo "extension=oci8.so" > /usr/local/etc/php/conf.d/oci8.ini

RUN apt-get clean -y

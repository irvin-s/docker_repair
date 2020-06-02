FROM centos:7
MAINTAINER Fer Uria <fauria@gmail.com>
LABEL Description="Linux + Apache 2.4 + PHP 5.4. CentOS 7 based. Includes .htaccess support and popular PHP5 features, including mail() function." \
	License="Apache License 2.0" \
	Usage="docker run -d -p [HOST PORT NUMBER]:80 -v [HOST WWW DOCUMENT ROOT]:/var/www/html fauria/lap" \
	Version="1.0"

RUN yum -y update && yum clean all
RUN yum -y install httpd && yum clean all
RUN yum -y install gcc php-pear php-devel make openssl-devel && yum clean all
RUN yum install -y \
	psmisc \
	httpd \
	postfix \
	php \
	php-common \
	php-dba \
	php-gd \
	php-intl \
	php-ldap \
	php-mbstring \
	php-mysqlnd \
	php-odbc \
	php-pdo \
	php-pecl-memcache \
	php-pgsql \
	php-pspell \
	php-recode \
	php-snmp \
	php-soap \
	php-xml \
	php-xmlrpc \
	ImageMagick \
	ImageMagick-devel

RUN sh -c 'printf "\n" | pecl install mongo imagick'
RUN sh -c 'echo short_open_tag=On >> /etc/php.ini'
RUN sh -c 'echo extension=mongo.so >> /etc/php.ini'
RUN sh -c 'echo extension=imagick.so >> /etc/php.ini'

ENV LOG_STDOUT **Boolean**
ENV LOG_STDERR **Boolean**
ENV LOG_LEVEL warn
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE UTC

COPY index.php /var/www/html/
COPY run-lap.sh /usr/sbin/
RUN chmod +x /usr/sbin/run-lap.sh
RUN chown -R apache:apache /var/www/html

VOLUME /var/www/html
VOLUME /var/log/httpd

EXPOSE 80

CMD ["/usr/sbin/run-lap.sh"]

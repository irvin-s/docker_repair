# Use Alpine Linux
FROM alpine:latest

# Maintainer
MAINTAINER Muhammad Zamroni <halo@matriphe.com>

# Environments
ENV TIMEZONE            Asia/Jakarta
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        100M

# Let's roll
RUN	apk update && \
	apk upgrade && \
	apk add --update tzdata && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk add --update \
		php5-mcrypt \
		php5-soap \
		php5-openssl \
		php5-gmp \
		php5-pdo_odbc \
		php5-json \
		php5-dom \
		php5-pdo \
		php5-zip \
		php5-mysql \
		php5-sqlite3 \
		php5-apcu \
		php5-pdo_pgsql \
		php5-bcmath \
		php5-gd \
		php5-xcache \
		php5-odbc \
		php5-pdo_mysql \
		php5-pdo_sqlite \
		php5-gettext \
		php5-xmlreader \
		php5-xmlrpc \
		php5-bz2 \
		php5-memcache \
		php5-mssql \
		php5-iconv \
		php5-pdo_dblib \
		php5-curl \
		php5-ctype \
		php5-phar \
		php5-cli && \
    
    # Set environments
	sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php5/php.ini && \
	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php5/php.ini && \
    sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php5/php.ini && \
    sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php5/php.ini && \
    sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php5/php.ini && \
    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php5/php.ini && \
	
	# Cleaning up
	mkdir /www && \
	apk del tzdata && \
	rm -rf /var/cache/apk/*

# Set Workdir
WORKDIR /www

# Expose volumes
VOLUME ["/www"]

# Expose ports
EXPOSE 9000

# Entry point
CMD ["/usr/bin/php", "-a"]

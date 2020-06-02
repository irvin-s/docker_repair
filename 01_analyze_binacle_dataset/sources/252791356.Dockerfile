FROM alpine:latest  
  
ENV TIMEZONE="Europe/Dublin"  
  
RUN apk update && \  
apk add --no-cache bash \  
wget \  
curl \  
supervisor \  
nginx \  
#php5-apcu \  
php5-bcmath \  
php5-bz2 \  
php5-ctype \  
php5-curl \  
php5-dom \  
php5-fpm \  
php5-gd \  
php5-gettext \  
php5-gmp \  
php5-iconv \  
php5-json \  
php5-mcrypt \  
#php5-memcache \  
php5-mssql \  
php5-mysql \  
php5-mysqli \  
php5-odbc \  
php5-openssl \  
php5-pdo \  
php5-pdo_dblib \  
php5-pdo_mysql \  
php5-pdo_odbc \  
php5-pdo_pgsql \  
php5-pdo_sqlite \  
php5-soap \  
php5-sqlite3 \  
#php5-xcache \  
php5-xmlreader \  
php5-xmlrpc \  
php5-zip \  
tzdata \  
varnish \  
varnish-geoip  
  
COPY www/* /www/  
COPY etc/supervisord.conf /etc/supervisord.conf  
  
RUN adduser -D -u 1000 -g 'www' www && \  
chown -R www:www /var/lib/nginx && \  
chown -R www:www /www && \  
chown -R varnish:varnish /etc/varnish && \  
mkdir /var/log/php-fpm  
  
  
  
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \  
echo "${TIMEZONE}" > /etc/timezone && \  
sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php5/php.ini  
  
EXPOSE 80  
  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]  


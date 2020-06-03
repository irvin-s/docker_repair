FROM ubuntu:14.04  
ENV DEBIAN_FRONTEND="noninteractive" \  
PHP_DATE_TIMEZONE="Asia/Shanghai" \  
PHP_MAX_EXECUTION_TIME="30" \  
PHP_MEMORY_LIMIT="128M" \  
PHP_ERROR_REPORTING="E_ALL & ~E_DEPRECATED & ~E_STRICT" \  
PHP_UPLOAD_MAX_FILESIZE="2M" \  
APACHE_STARTSERVERS="5" \  
APACHE_MINSPARESERVERS="5" \  
APACHE_MAXSPARESERVERS="10" \  
APACHE_MAXREQUESTWORKERS="100" \  
APACHE_MAXCONNECTIONSPERCHILD="0" \  
APACHE_TIMEOUT="300" \  
APACHE_MAXKEEPALIVEREQUESTS="100" \  
APACHE_KEEPALIVETIMEOUT="5" \  
APACHE_MAX_ACCESSLOG="500M" \  
APACHE_MAX_ERRORLOG="50M" \  
TIMEZONE="Asia/Shanghai"  
COPY prepare.sh /usr/local/bin  
COPY run.sh /usr/local/bin  
RUN /usr/local/bin/prepare.sh  
  
COPY apache2.conf /etc/apache2/  
COPY php.ini /etc/php5/apache2/php.ini  
COPY php.ini /etc/php5/cli/php.ini  
COPY mpm_prefork.conf /etc/apache2/mods-enabled/  
COPY site.conf /etc/apache2/sites-enabled/  
  
EXPOSE 80  
CMD ["/usr/local/bin/run.sh"]  
  


# Configure odbc  
FROM debian:jessie  
RUN apt-get update && \  
apt-get install -y php5-fpm php5-odbc php5-curl \  
&& \  
rm -rf /var/lib/apt/lists/*  
  
RUN set -ex \  
&& { \  
echo '[ODBC Data Sources]'; \  
echo 'VOS = Virtuoso'; \  
echo; \  
echo '[VOS]'; \  
echo 'Driver = /usr/local/virtuoso-opensource/lib/virtodbc.so'; \  
echo 'Address = virtuoso:1111'; \  
} | tee /etc/odbc.ini  
  
WORKDIR /var/www/html  
  
RUN set -ex \  
&& cd /etc/php5/fpm \  
&& { \  
echo '[global]'; \  
echo 'error_log = /proc/self/fd/2'; \  
echo; \  
echo '[www]'; \  
echo '; if we send this to /proc/self/fd/1, it never appears'; \  
echo 'access.log = /proc/self/fd/2'; \  
echo; \  
echo 'clear_env = no'; \  
echo; \  
echo '; Ensure worker stdout and stderr are sent to the main error log.'; \  
echo 'catch_workers_output = yes'; \  
} | tee pool.d/docker.conf \  
&& { \  
echo '[global]'; \  
echo 'daemonize = no'; \  
echo; \  
echo '[www]'; \  
echo 'listen = [::]:9000'; \  
} | tee pool.d/zz-docker.conf  
  
EXPOSE 9000  
CMD ["php5-fpm"]  


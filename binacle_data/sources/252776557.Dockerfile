FROM castorinop/php-nextcloud  
  
RUN apk add --update php7-fpm  
  
#FROM php:fpm-alpine  
RUN set -ex \  
&& cd /etc/php7 \  
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
} | tee php-fpm.d/docker.conf \  
&& { \  
echo '[global]'; \  
echo 'daemonize = no'; \  
echo; \  
echo '[www]'; \  
echo 'listen = [::]:9000'; \  
} | tee php-fpm.d/zz-docker.conf \  
&& { \  
echo 'include = /etc/php7/php-fpm.d/*.conf'; \  
echo '[www]'; \  
echo 'user = nobody'; \  
echo 'group = nobody'; \  
echo 'pm = dynamic'; \  
echo 'pm.max_children = 5'; \  
echo 'pm.start_servers = 2'; \  
echo 'pm.min_spare_servers = 1'; \  
echo 'pm.max_spare_servers = 3'; \  
} | tee php-fpm.conf  
  
#FIX CONFIG remove 127.0.0.1:9000  
EXPOSE 9000  
#CMD ["php-fpm7"]  
COPY entrypoint.sh /usr/local/bin  
RUN chmod 755 /usr/local/bin/*sh  
ENTRYPOINT ["entrypoint.sh"]  
  
RUN apk add --update php7-xdebug  
RUN mkdir -p /etc/php7/php-fpm.d/  
# --repository http://dl-cdn.alpinelinux.org/alpine/edge/community  
RUN set -ex \  
&& { \  
echo '[xdebug]'; \  
echo 'zend_extension=xdebug.so'; \  
echo 'xdebug.remote_enable=1'; \  
echo 'xdebug.remote_port=9009'; \  
echo 'xdebug.remote_connect_back=1'; \  
echo 'xdebug.remote_handler=dbgp'; \  
echo 'xdebug.remote_mode=req'; \  
echo "xdebug.remote_autostart=1"; \  
} | tee /etc/php7/php-fpm.d/xdebug.ini  
  
ENV PHP_INI_SCAN_DIR='/etc/php7/conf.d:/etc/php7/php-fpm.d/'  


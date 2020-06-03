FROM wpdev-base

WORKDIR /var/www

ADD ./configs/nginx.conf /etc/nginx/nginx.conf

RUN chown -R www-data:www-data /var/www

# Setup xdebug
ENV XDEBUGINI_PATH=/etc/php/7.0/fpm/conf.d/20-xdebug.ini
COPY configs/xdebug.ini /tmp/xdebug.ini
RUN cat /tmp/xdebug.ini >> $XDEBUGINI_PATH
RUN echo "xdebug.remote_host="`/sbin/ip route|awk '/default/ { print $3 }'` >> $XDEBUGINI_PATH

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]

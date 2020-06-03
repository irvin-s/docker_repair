FROM wpdev-base

WORKDIR /var/www

ADD configs/nginx.conf /etc/nginx/nginx.conf

RUN chown -R www-data:www-data /var/www

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]

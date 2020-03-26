FROM bigm/base-deb-tools

# http://www.if-not-true-then-false.com/2011/nginx-and-php-fpm-configuration-and-optimizing-tips-and-tricks/

RUN /xt/tools/_ppa_install ppa:nginx/stable ca-certificates ssl-cert nginx

VOLUME ["/var/cache/nginx"]
EXPOSE 80 443

ADD supervisor/* /etc/supervisord.d/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# TODO install goaccess to analyze access logs

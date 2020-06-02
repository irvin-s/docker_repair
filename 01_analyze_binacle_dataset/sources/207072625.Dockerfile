FROM unocha/alpine-base-nginx-extras:uploadprogress

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

COPY nginx.conf default.conf index.html run_nginx /

# Install nginx.
RUN mkdir -p /etc/services.d/nginx /srv/www/html /var/log/nginx /var/cache/nginx /etc/nginx/conf.d && \
    mv /run_nginx /etc/services.d/nginx/run && \
    mv /nginx.conf /etc/nginx/nginx.conf && \
    mv /default.conf /etc/nginx/conf.d/default.conf && \
    mv /index.html /srv/www/html/default.conf

EXPOSE 80 443

VOLUME ["/var/cache/nginx", "/var/log/nginx", "/srv/www/html"]

# Volumes
# - Conf: /etc/nginx/conf.d (default.conf)
# - Cache: /var/cache/nginx
# - Logs: /var/log/nginx
# - Data: /srv/www/html

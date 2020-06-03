FROM nginx:1.15

MAINTAINER Karl Hughes <khughes.me@gmail.com>

ENV DATA_DIR /var/www

ADD start.sh /usr/local/bin/

ADD conf /etc/nginx/conf.d/

# Disable daemon mode
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    # Backup configs
    cp -a /etc/nginx/conf.d /etc/nginx/.conf.d.orig && \
    rm -f /etc/nginx/conf.d/default.conf && \
    # Make sure the data directory is created and ownership correct
    mkdir -p $DATA_DIR && \
    chown -R www-data:www-data $DATA_DIR

WORKDIR /etc/nginx

CMD ["/usr/local/bin/start.sh"]

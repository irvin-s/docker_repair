FROM xcgd/nginx-vts:stable

RUN chown -R nginx:nginx /etc/nginx && \
    chown nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    mkdir /var/run/nginx && \
    chown nginx:nginx /var/run/nginx

ADD docker/base/base.inc /etc/nginx/conf.d/base.inc
ADD docker/base/nginx.conf /etc/nginx/nginx.conf
ADD docker/base/metrics.conf /etc/nginx/conf.d/metrics.conf
ADD docker/servicesmw/site.conf /etc/nginx/conf.d/default.conf

# static mediawiki files
ADD apple-touch-icon.png /usr/wikia/slot1/current/src/apple-touch-icon.png

ADD skins /usr/wikia/slot1/current/src/skins
ADD resources /usr/wikia/slot1/current/src/resources
ADD extensions /usr/wikia/slot1/current/src/extensions

USER nginx

# validate configuration files for syntax errors
RUN nginx -c /etc/nginx/nginx.conf -t

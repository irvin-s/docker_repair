FROM webdevops/php-nginx:alpine-3

# https://github.com/eolinker/eolinker
ENV VERSION="2_1_7"

ADD  ext/10-location-root.conf /opt/docker/etc/nginx/vhost.common.d/10-location-root.conf
# ADD  10-init.sh   /opt/docker/bin/service.d/dnsmasq.d/10-init.sh

RUN mkdir -p /app \
    && wget -O /tmp/app.zip "https://raw.githubusercontent.com/eolinker/eolinker/master/release/eolinker_os_$VERSION.zip" \
    && unzip /tmp/app.zip -d /app/ \
    && rm -rf /tmp/*

RUN chown application:application -R /app/
FROM alpine:edge
MAINTAINER Etopian Inc. <contact@etopian.com>

LABEL   devoply.type="site" \
        devoply.cms="drupal" \
        devoply.framework="drupal" \
        devoply.language="php" \
        devoply.require="mariadb etopian/nginx-proxy" \
        devoply.recommend="redis" \
        devoply.description="Drupal on Nginx and PHP-FPM with Drush." \
        devoply.name="Drupal"

# BUILD NGINX
ENV NGINX_VERSION nginx-1.9.12

# Add s6-overlay
ENV S6_OVERLAY_VERSION v1.17.2.0

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xvfz /tmp/s6-overlay.tar.gz -C /

ADD root /

# Add the files
RUN rm /etc/s6/services/s6-fdholderd/down

RUN apk --update add nginx && apk del nginx

RUN apk --update add pcre openssl-dev pcre-dev zlib-dev wget build-base \
    ca-certificates git linux-headers && \
    mkdir -p /tmp/src && \
    cd /tmp/src && \
    wget http://nginx.org/download/${NGINX_VERSION}.tar.gz && \
    wget https://raw.githubusercontent.com/masterzen/nginx-upload-progress-module/master/ngx_http_uploadprogress_module.c && \
    git clone https://github.com/masterzen/nginx-upload-progress-module /tmp/nginx-upload-progress-module && \
    tar -zxvf ${NGINX_VERSION}.tar.gz && \
    cd /tmp/src/${NGINX_VERSION} && \
    ./configure \
        --conf-path=/etc/nginx/nginx.conf \
        --with-http_ssl_module \
        --with-http_gzip_static_module \
        --with-pcre \
        --with-file-aio \
        --with-http_flv_module \
        --with-http_realip_module \
        --with-http_mp4_module \
        --with-http_stub_status_module \
        --with-http_gunzip_module \
        --add-module=/tmp/nginx-upload-progress-module \
        --prefix=/etc/nginx \
        --http-log-path=/var/log/nginx/access.log \
        --error-log-path=/var/log/nginx/error.log \
        --sbin-path=/usr/local/sbin/nginx && \
    make && \
    make install && \
    apk del --purge build-base openssl-dev zlib-dev git && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

RUN apk update \
    && apk add bash less vim ca-certificates \
    php-fpm php-json php-zlib php-xml php-pdo php-phar php-openssl \
    php-pdo_mysql php-mysqli \
    php-gd php-iconv php-mcrypt \
    php-mysql php-curl php-opcache php-ctype php-apcu \
    php-intl php-bcmath php-dom php-xmlreader curl git \ 
    mysql-client php-pcntl php-posix apk-cron postfix musl

RUN rm -rf /var/cache/apk/* && rm -rvf /etc/nginx && mkdir -p /etc/nginx

ADD files/nginx/ /etc/nginx/
ADD files/php-fpm.conf /etc/php/
ADD files/drush.sh /

ADD files/postfix/main.cf /etc/postfix/main.cf.new
ADD files/postfix/setup_ses.sh /setup_ses.sh


RUN mkdir -p /DATA/htdocs && \
    mkdir -p /DATA/logs/{nginx,php-fpm} && \
    mkdir -p /var/log/nginx/ && \
    mkdir -p /var/log/php-fpm/ && \    
    chown -R nginx:nginx /var/log/nginx/ && \
    mkdir -p /var/cache/nginx/microcache && \
    chown -R nginx:nginx /var/cache/nginx/microcache && \
    mkdir -p /var/www/localhost/htdocs && \
    chown -R nginx:nginx /var/www/localhost/htdocs && \
    chown -R  nginx:nginx /DATA && \    
    chmod +x /setup_ses.sh && \ 
    chmod +x /drush.sh

RUN sed -i 's/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/sbin\/nologin/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/bin\/bash/g' /etc/passwd && \
    sed -i 's/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/sbin\/nologin/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/bin\/bash/g' /etc/passwd- && \
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/php.ini && \
    crontab -u nginx -l | { cat; echo "*/15 * * * * /usr/bin/drush --root=/DATA/htdocs core-cron --yes"; } | crontab -u nginx -

    
# configure postfix use to amazon ses to send mail.
ENV SES_HOST="email-smtp.us-east-1.amazonaws.com" SES_PORT="587" \
    SES_USER="" SES_SECRET="" TERM="xterm" \
    DB_HOST="172.17.0.1" DB_USER="" DB_PASS="" DB_NAME=""

RUN /setup_ses.sh && /drush.sh

EXPOSE 80
VOLUME ["/DATA"]
ENTRYPOINT ["/init"]
#CMD ["/run.sh"]

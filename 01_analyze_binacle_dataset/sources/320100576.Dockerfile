FROM alpine:latest

MAINTAINER niuyuxian <ncc0706@gmail.com>

ENV TZ Asia/Shanghai
ENV NGINX_VERSION nginx-1.12.1

# for china
RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/main\n" > /etc/apk/repositories
RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/community\n" >> /etc/apk/repositories

## supervisor
RUN apk --update add tzdata curl supervisor \
	&& cp /usr/share/zoneinfo/$TZ /etc/localtime \
	&& echo $TZ > /etc/timezone \
	&& mkdir -p /var/logs/supervisor \
    && mkdir -p /var/run/supervisor

# nginx
RUN apk add openssl-dev pcre-dev zlib-dev wget build-base \
    && addgroup -g 499 -S nginx \
    && adduser -HDu 499 -s /sbin/nologin -g 'web server' -G nginx nginx \
    && mkdir -p /tmp/src \
    && cd /tmp/src \
    && wget http://nginx.org/download/${NGINX_VERSION}.tar.gz \
    && tar -zxvf ${NGINX_VERSION}.tar.gz \
    && cd /tmp/src/${NGINX_VERSION} \
    && ./configure \
       --prefix=/usr/local/nginx \
       --conf-path=/etc/nginx/nginx.conf \
       --user=nginx \
       --group=nginx \
       --error-log-path=/var/log/nginx/error.log \
       --http-log-path=/var/log/nginx/access.log \
       --pid-path=/var/run/nginx/nginx.pid \
       --lock-path=/var/lock/nginx.lock \
       --with-http_ssl_module \
       --with-http_stub_status_module \
       --with-http_gzip_static_module \
       --with-http_flv_module \
       --with-http_mp4_module \
       --http-client-body-temp-path=/var/tmp/nginx/client \
       --http-proxy-temp-path=/var/tmp/nginx/proxy \
       --http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
       --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
    && make && make install \
    && mkdir -p /var/tmp/nginx/{client,fastcgi,proxy,uwsgi} \
    && mkdir -p /etc/nginx/conf.d \
    && apk del build-base \
    && rm -rf /tmp/src

ENV PATH /usr/local/nginx/sbin:$PATH

RUN apk add --update \
        php7 \
        php7-bcmath \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-fileinfo \
        php7-fpm \
        php7-gd \
        php7-iconv \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqli \
        php7-mysqlnd \
        php7-opcache \
        php7-openssl \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-phar \
        php7-posix \
        php7-session \
        php7-soap \
        php7-xml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-zip \
    && rm -rf /var/cache/apk/*


COPY config/supervisord.conf /etc/supervisord.conf

# nginx config
COPY config/nginx/conf.d/ /etc/nginx/conf.d/
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf

COPY config/php/php.ini /etc/php7/conf.d/50-setting.ini
COPY config/php/php-fpm.conf /etc/php7/php-fpm.conf

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord"]
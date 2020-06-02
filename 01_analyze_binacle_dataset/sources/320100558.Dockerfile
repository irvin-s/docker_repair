FROM alpine:latest
MAINTAINER niuyuxian <"ncc0706@gmail.com">

ENV TZ Asia/Shanghai

#ENV NGINX_VERSION 1.10.1

# 国内镜像
#RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/main\n" > /etc/apk/repositories

RUN apk --update add tzdata curl \
	&& cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV NGINX_VERSION nginx-1.12.1

RUN apk --update add openssl-dev pcre-dev zlib-dev wget build-base \
    && addgroup -g 499 -S nginx \
    && adduser -HDu 499 -s /sbin/nologin -g 'web server' -G nginx nginx \
    && mkdir -p /tmp/src \
    && cd /tmp/src \
    && wget http://nginx.org/download/${NGINX_VERSION}.tar.gz \
    && tar -zxvf ${NGINX_VERSION}.tar.gz \
    && wget https://github.com/arut/nginx-rtmp-module/archive/v1.1.11.tar.gz -O nginx-rtmp-module-1.1.11.tar.gz \
    && tar -zxvf nginx-rtmp-module-1.1.11.tar.gz \
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
       --add-module=../nginx-rtmp-module-1.1.11 \
    && make && make install \
    && mkdir -p /var/tmp/nginx/{client,fastcgi,proxy,uwsgi} \
    && echo "daemon off;" >> /etc/nginx/nginx.conf \
    && apk del build-base \
    && rm -rf /tmp/src \
    && rm -rf /var/cache/apk/*

ENV PATH /usr/local/nginx/sbin:$PATH

# forward request and error logs to docker log collector
#RUN ln -sf /dev/stdout /var/log/nginx/access.log
#RUN ln -sf /dev/stderr /var/log/nginx/error.log

#VOLUME ["/var/log/nginx"]
#WORKDIR /etc/nginx

COPY nginx/nginx.conf /etc/nginx/nginx.conf

COPY data /opt/show

EXPOSE 80 443 1935

CMD ["nginx", "-g", "daemon off;"]
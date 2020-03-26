#Version 0.1

## fastdfs can not use alpine
FROM centos:7

MAINTAINER juneryo <https://github.com/juneryo/fastdfs-nginx-server>

## fastdfs environment
ENV FASTDFS_VERSION master
ENV LIBFASTCOMMON_VERSION 1.0.35
## same as base_path in conf/storage.conf
ENV FASTDFS_BASE_PATH /data/fdfs

## nginx environment
ENV NGINX_VERSION 1.13.3
ENV ECHO_NGINX_MODULE_VERSION master
ENV FASTDFS_NGINX_MODULE_VERSION master
ENV NGINX_EVAL_MODULE_VERSION master
ENV NGX_HTTP_REDIS_VERSION 0.3.8

## create and link folders
RUN mkdir -p /usr/src \
	&& mkdir -p $FASTDFS_BASE_PATH/data/M00 \
	&& mkdir /boot \
	&& ln -s $FASTDFS_BASE_PATH/data  $FASTDFS_BASE_PATH/data/M00

## install dependency packages
RUN yum install -y gcc gcc-c++ gd gd-devel geoip geoip-devel gnupg libc libc-devel libevent libevent-devel libxslt libxslt-devel linux-headers openssl openssl-devel pcre pcre-devel perl unzip zlib zlib-devel

## install fastdfs common lib
ADD install/fastdfs/libfastcommon-$LIBFASTCOMMON_VERSION.zip /usr/src/
RUN cd /usr/src \
	&& unzip libfastcommon-$LIBFASTCOMMON_VERSION.zip \
	&& cd libfastcommon-$LIBFASTCOMMON_VERSION \
	&& ./make.sh \
	&& ./make.sh install

## install fastdfs
ADD install/fastdfs/fastdfs-$FASTDFS_VERSION.zip /usr/src/
RUN cd /usr/src \
	&& unzip fastdfs-$FASTDFS_VERSION.zip \
	&& cd fastdfs-$FASTDFS_VERSION \
	&& ./make.sh \
	&& ./make.sh install \
	&& cp conf/*.* /etc/fdfs

## unzip nginx modules
ADD install/nginx/modules/echo-nginx-module-$ECHO_NGINX_MODULE_VERSION.zip /usr/src/
ADD install/nginx/modules/fastdfs-nginx-module-$FASTDFS_NGINX_MODULE_VERSION.zip /usr/src/
ADD install/nginx/modules/nginx-eval-module-$NGINX_EVAL_MODULE_VERSION.zip /usr/src/
## command ADD will auto unzip tar.gz
ADD install/nginx/modules/ngx_http_redis-$NGX_HTTP_REDIS_VERSION.tar.gz /usr/src/
RUN cd /usr/src \
	&& unzip echo-nginx-module-$ECHO_NGINX_MODULE_VERSION.zip \
	&& unzip fastdfs-nginx-module-$FASTDFS_NGINX_MODULE_VERSION.zip \
	&& unzip nginx-eval-module-$NGINX_EVAL_MODULE_VERSION.zip

## install nginx with extra modules
## refer to： https://github.com/nginxinc/docker-nginx/blob/1.13.2/mainline/alpine/Dockerfile
ADD install/nginx/nginx-$NGINX_VERSION.tar.gz /usr/src/
RUN mkdir -p /var/cache/nginx/client_temp \
	&& mkdir /var/cache/nginx/proxy_temp \
	&& mkdir /var/cache/nginx/fastcgi_temp \
	&& mkdir /var/cache/nginx/uwsgi_temp \
	&& mkdir /var/cache/nginx/scgi_temp
RUN CONFIG="\
		--prefix=/etc/nginx \
		--sbin-path=/usr/sbin/nginx \
		--modules-path=/usr/lib/nginx/modules \
		--conf-path=/etc/nginx/nginx.conf \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/run/nginx.lock \
		--http-client-body-temp-path=/var/cache/nginx/client_temp \
		--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
		--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
		--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
		--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
		--with-http_ssl_module \
		--with-http_realip_module \
		--with-http_addition_module \
		--with-http_sub_module \
		--with-http_dav_module \
		--with-http_flv_module \
		--with-http_mp4_module \
		--with-http_gunzip_module \
		--with-http_gzip_static_module \
		--with-http_random_index_module \
		--with-http_secure_link_module \
		--with-http_stub_status_module \
		--with-http_auth_request_module \
		--with-http_xslt_module=dynamic \
		--with-http_image_filter_module=dynamic \
		--with-http_geoip_module=dynamic \
		--with-threads \
		--with-stream \
		--with-stream_ssl_module \
		--with-stream_ssl_preread_module \
		--with-stream_realip_module \
		--with-stream_geoip_module=dynamic \
		--with-http_slice_module \
		--with-mail \
		--with-mail_ssl_module \
		--with-compat \
		--with-file-aio \
		--with-http_v2_module \

		--add-module=/usr/src/echo-nginx-module-$ECHO_NGINX_MODULE_VERSION \
		--add-module=/usr/src/fastdfs-nginx-module-$FASTDFS_NGINX_MODULE_VERSION/src \
		--add-module=/usr/src/nginx-eval-module-$NGINX_EVAL_MODULE_VERSION \
		--add-module=/usr/src/ngx_http_redis-$NGX_HTTP_REDIS_VERSION \
	" \
	&& cd /usr/src/nginx-$NGINX_VERSION \
	&& ./configure $CONFIG --with-debug \
	&& make -j$(getconf _NPROCESSORS_ONLN) \
	&& mv objs/nginx objs/nginx-debug \
	&& mv objs/ngx_http_xslt_filter_module.so objs/ngx_http_xslt_filter_module-debug.so \
	&& mv objs/ngx_http_image_filter_module.so objs/ngx_http_image_filter_module-debug.so \
	&& mv objs/ngx_http_geoip_module.so objs/ngx_http_geoip_module-debug.so \
	&& mv objs/ngx_stream_geoip_module.so objs/ngx_stream_geoip_module-debug.so \
	&& ./configure $CONFIG \
	&& make -j$(getconf _NPROCESSORS_ONLN) \
	&& make install \
	&& rm -rf /etc/nginx/html/ \
	&& mkdir /etc/nginx/conf.d/ \
	&& mkdir -p /usr/share/nginx/html/ \
	&& install -m644 html/index.html /usr/share/nginx/html/ \
	&& install -m644 html/50x.html /usr/share/nginx/html/ \
	&& install -m755 objs/nginx-debug /usr/sbin/nginx-debug \
	&& install -m755 objs/ngx_http_xslt_filter_module-debug.so /usr/lib/nginx/modules/ngx_http_xslt_filter_module-debug.so \
	&& install -m755 objs/ngx_http_image_filter_module-debug.so /usr/lib/nginx/modules/ngx_http_image_filter_module-debug.so \
	&& install -m755 objs/ngx_http_geoip_module-debug.so /usr/lib/nginx/modules/ngx_http_geoip_module-debug.so \
	&& install -m755 objs/ngx_stream_geoip_module-debug.so /usr/lib/nginx/modules/ngx_stream_geoip_module-debug.so \
	&& ln -s ../../usr/lib/nginx/modules /etc/nginx/modules \
	&& strip /usr/sbin/nginx* \
	&& strip /usr/lib/nginx/modules/*.so \
	\
	## Bring in gettext so we can get `envsubst`, then throw
	## the rest away. To do this, we need to install `gettext`
	## then move `envsubst` out of the way so `gettext` can
	## be deleted completely, then move `envsubst` back.
	&& yum install -y gettext \
	&& mv /usr/bin/envsubst /tmp/ \
	&& mv /tmp/envsubst /usr/local/bin/

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/nginx.vh.default.conf /etc/nginx/conf.d/default.conf

## some important fast and fast-nginx-module params:
## base_path in tracker.conf
## base_path, store_path0, tracker_server in storage.conf and mod_fastdfs.conf
COPY conf/tracker.conf /etc/fdfs/tracker.conf
COPY conf/storage.conf /etc/fdfs/storage.conf
COPY conf/http.conf /etc/fdfs/http.conf
COPY conf/mod_fastdfs.conf /etc/fdfs/mod_fastdfs.conf
COPY start.sh /boot/start.sh
RUN chmod 755 /boot/start.sh

## nginx port
EXPOSE 24001 24002
## fastdfs Tracker,Storage,FastDHT port
EXPOSE 22122 23000 11411

STOPSIGNAL SIGTERM

CMD ["/boot/start.sh"]
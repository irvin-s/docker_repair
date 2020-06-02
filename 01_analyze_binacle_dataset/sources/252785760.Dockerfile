FROM alpine:3.3  
MAINTAINER Tim Dettrick <t.dettrick@uq.edu.au>  
  
# Statically compile nginx, then remove build tools  
RUN export NGINX_VERSION=1.8.1 && \  
export NGINX_CACHE_DIR=/var/cache/nginx && \  
export NGINX_LOG_DIR=/var/log/nginx && \  
export NGINX_RUN_DIR=/var/run/nginx && \  
addgroup -S nginx && \  
adduser -S -D -h /var/www -s /sbin/nologin -G nginx nginx && \  
mkdir -p $NGINX_CACHE_DIR $NGINX_LOG_DIR $NGINX_RUN_DIR /run && \  
chown nginx:nginx $NGINX_CACHE_DIR $NGINX_LOG_DIR $NGINX_RUN_DIR /run && \  
apk add --update openssl-dev pcre-dev zlib-dev build-base && \  
mkdir /src && \  
wget -O - http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \  
| tar xzv -C /src && \  
cd /src/nginx-${NGINX_VERSION} && \  
./configure \  
--with-cc-opt="-static" \  
--with-ld-opt="-static" \  
--prefix=/usr \  
--conf-path=/etc/nginx/nginx.conf \  
--http-client-body-temp-path=$NGINX_CACHE_DIR/client_body_temp \  
--http-proxy-temp-path=$NGINX_CACHE_DIR/proxy_temp \  
--http-log-path=$NGINX_LOG_DIR/access.log \  
--error-log-path=$NGINX_LOG_DIR/error.log \  
--pid-path=$NGINX_RUN_DIR/nginx.pid \  
--lock-path=$NGINX_RUN_DIR/nginx.lock \  
--with-http_auth_request_module \  
--without-http_ssi_module \  
--without-http_userid_module \  
--without-http_access_module \  
--without-http_auth_basic_module \  
--without-http_autoindex_module \  
--without-http_geo_module \  
--without-http_split_clients_module \  
--without-http_fastcgi_module \  
--without-http_uwsgi_module \  
--without-http_scgi_module \  
--without-http_memcached_module \  
--without-http_limit_conn_module \  
--without-http_limit_req_module \  
--without-http_empty_gif_module \  
--without-http_browser_module \  
&& \  
make && \  
make install && \  
apk del openssl-dev pcre-dev zlib-dev build-base && \  
cd - && \  
rm -rf /src && \  
rm -rf /var/cache/apk/*  
  
ADD /etc /etc  
ADD /opt /opt  
  
VOLUME ["/var/cache", "/var/log"]  
  
RUN mkdir -p /etc/nginx/conf.d && \  
touch /etc/nginx/conf.d/variables.conf && \  
chown nginx:nginx /etc/nginx/conf.d/variables.conf  
  
USER nginx  
  
EXPOSE 8080  
  
CMD /opt/run.sh  


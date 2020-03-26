#!/usr/bin/env docker

# Nginx/OpenResty (Sandbox)
#
# VERSION               0.0.1
#
# BUILD:
#   docker build -t openresty-nginx - < /vagrant/Dockerfile.openresty
#
# RUN:
#   docker run -d -v /vagrant:/app -p 8080:8080 openresty-nginx
#

FROM nginx-base:latest
MAINTAINER Jonas Grimfelt <grimen@gmail.com>

## PATH
ENV PATH /usr/local/openresty/nginx/sbin:/usr/local/openresty/luajit/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib
RUN ldconfig

## NGINX/OPENRESTY
WORKDIR /tmp/
RUN wget http://openresty.org/download/ngx_openresty-1.4.3.3.tar.gz
RUN tar -xzvf ngx_openresty-1.4.3.3.tar.gz
WORKDIR /tmp/ngx_openresty-1.4.3.3
RUN ./configure --with-cc-opt="-I /usr/local/include" --with-ld-opt="-L /usr/local/lib" --with-luajit --with-pcre-jit \
  --without-mail_pop3_module \
  --without-mail_pop3_module \
  --without-mail_imap_module \
  --without-mail_smtp_module \
  --without-http_autoindex_module \
  --without-http_browser_module \
  --without-http_empty_gif_module \
  --without-http_fastcgi_module \
  --without-http_geo_module \
  --without-http_memcached_module \
  --without-http_scgi_module \
  --without-http_uwsgi_module \
  --with-http_addition_module \
  --with-http_gzip_static_module \
  --with-http_realip_module \
  --with-http_ssl_module \
  --with-http_sub_module \
  --with-http_spdy_module \
  --with-ipv6 \
  --with-poll_module \
  --with-select_module \
  --with-debug
RUN make -j$(nproc) && make install

## LOCATE DB
RUN updatedb

# APP
WORKDIR /
RUN ufw allow 80 && ufw allow 8080 && ufw allow 443
EXPOSE 80:80 8080:8080 443:443

# NOTE: Nginx `daemon` should be turned off when running in a container.

# Default entrypoint
ENTRYPOINT ["nginx", "-p", "/usr/local/openresty/nginx/", "-c", "/usr/local/openresty/nginx/conf/nginx.conf"]

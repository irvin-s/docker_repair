FROM index.alauda.cn/jamespan/ng-proxy:v20151128.102950

MAINTAINER Pan Jiabang <panjiabang@gmail.com> 

#COPY ./ngx_openresty-1.9.3.2 /tmp/src/ngx_openresty-1.9.3.2
#RUN cd /tmp/src/ngx_openresty-1.9.3.2 && \
#    ./configure \
#        --prefix=/usr/share/nginx \
#        --sbin-path=/usr/sbin/nginx \
#        --conf-path=/etc/nginx/nginx.conf \
#        --pid-path=/var/run/nginx/nginx.pid \
#        --lock-path=/var/run/nginx/nginx.lock \
#        --error-log-path=/var/log/nginx/error.log \
#        --http-log-path=/var/log/nginx/access.log \
#        --with-ipv6 \
#        --with-file-aio \
#        --with-pcre-jit \
#        --with-http_dav_module \
#        --with-http_ssl_module \
#        --with-http_stub_status_module \
#        --with-http_gzip_static_module \
#        --with-http_spdy_module \
#        --with-http_auth_request_module \
#        --with-mail \
#        --with-mail_ssl_module \
#        --without-http_lua_upstream \
#        --add-module=/tmp/src/nginx-upstream-fair-master && \
#    make && \
#    make install && make clean

# Copy Config
COPY nginx.conf /etc/nginx/nginx.conf
COPY sites/* /etc/nginx/sites-enabled/
COPY lua/* /etc/nginx/lua/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

# Start Nginx and with dockerize
CMD ["nginx", "-g", "daemon off;"]

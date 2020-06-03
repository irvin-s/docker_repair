FROM alpine:3.2

MAINTAINER Pan Jiabang <panjiabang@gmail.com> 

# Install OpenResty From Source

RUN mkdir -p /tmp/src && \
    cd /tmp/src && \
    apk update && \
    apk add openssl pcre libgcc perl && \
    wget https://github.com/gnosek/nginx-upstream-fair/archive/master.zip && \
    unzip master.zip && \
    apk add openssl-dev pcre-dev zlib-dev readline-dev ncurses-dev linux-headers build-base && \
    wget https://openresty.org/download/ngx_openresty-1.9.3.2.tar.gz && \
    tar -zxvf ngx_openresty-1.9.3.2.tar.gz && \
    cd /tmp/src/ngx_openresty-1.9.3.2 && \
    wget https://raw.githubusercontent.com/JamesPan/lua-upstream-nginx-module/6b40d40a42aa6a8e4214a8c247b7d32ce9d37895/src/ngx_http_lua_upstream_module.c && \
    mv ngx_http_lua_upstream_module.c ./bundle/ngx_lua_upstream-0.04/src/ngx_http_lua_upstream_module.c && \
    ./configure \
        --prefix=/usr/share/nginx \
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --pid-path=/var/run/nginx/nginx.pid \
        --lock-path=/var/run/nginx/nginx.lock \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --with-ipv6 \
        --with-file-aio \
        --with-pcre-jit \
        --with-http_dav_module \
        --with-http_ssl_module \
        --with-http_stub_status_module \
        --with-http_gzip_static_module \
        --with-http_spdy_module \
        --with-http_auth_request_module \
        --with-mail \
        --with-mail_ssl_module \
        --add-module=/tmp/src/nginx-upstream-fair-master && \
    make && \
    make install && \
    make clean && \
    apk del build-base openssl-dev pcre-dev zlib-dev linux-headers perl && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/* && \
    echo "Done"

# Copy Config
COPY nginx.conf /etc/nginx/nginx.conf
COPY sites/* /etc/nginx/sites-enabled/
COPY lua/* /etc/nginx/lua/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

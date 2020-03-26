FROM alpine:3.4

ARG KONG_VERSION

ENV KONG_VERSION=${KONG_VERSION:-0.8.3} \
    OPENRESTY_VERSION=1.9.7.5 \
    LUAROCKS_VERSION=2.3.0 \
    OPENRESTY_PREFIX=/usr/local/openresty \
    LUAROCKS_INSTALL="luarocks install"

RUN echo "==> Installing dependencies..." \
 && apk add --no-cache --virtual=build-dependencies \
    make gcc musl-dev \
    pcre-dev openssl-dev zlib-dev ncurses-dev readline-dev \
    curl perl e2fsprogs-dev wget git \
 && mkdir -p /tmp/ngx_openresty \
 && cd /tmp/ngx_openresty \
 && echo "==> Downloading OpenResty..." \
 && curl -sSL http://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz | tar -xz \
 && cd openresty-* \
 && echo "==> Configuring OpenResty..." \
 && readonly NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
 && echo "using upto $NPROC threads" \
 && ./configure \
    --with-luajit \
    --with-pcre-jit \
    --with-ipv6 \
    --with-http_realip_module \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --without-http_ssi_module \
    --without-http_userid_module \
    --without-http_uwsgi_module \
    --without-http_scgi_module \
    -j${NPROC} \
 && echo "==> Building OpenResty..." \
 && make -j${NPROC} \
 && echo "==> Installing OpenResty..." \
 && make install \
 && echo "==> Finishing..." \
 && echo "==> Configuring LuaRocks..." \
 && mkdir -p /tmp/luarocks \
 && cd /tmp/luarocks \
 && curl -sSL http://keplerproject.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz |tar -xz \
 && cd luarocks* \
 && ./configure \
    --with-lua=$OPENRESTY_PREFIX/luajit \
    --lua-suffix=jit-2.1.0-beta1 \
    --with-lua-include=$OPENRESTY_PREFIX/luajit/include/luajit-2.1 \
 && echo "==> Building&Installing OpenResty..." \
 && make build && make install \
 && echo "==> Finishing..." \
 && echo "==> Installing kong dependencies..." \
 && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/luarocks/lua-cjson-2.1.0-1.rockspec \
 && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/luarocks/luasocket-3.0rc1-2.rockspec \
 && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/thibaultcha/lua-cassandra-0.5.2-0.rockspec \
 && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/luarocks/lualogging-1.3.0-1.rockspec \
 && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/luarocks/luacrypto-0.3.2-1.rockspec \
 && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/leafo/pgmoon-1.4.0-1.rockspec \
 && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/leafo/loadkit-1.1.0-1.rockspec \
 && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/daurnimator/luatz-0.3-1.rockspec \
 && ${LUAROCKS_INSTALL} https://raw.githubusercontent.com/leafo/etlua/master/etlua-dev-1.rockspec \
 && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/leafo/lapis-1.3.1-1.rockspec \
 && ${LUAROCKS_INSTALL} lua_uuid \
 && wget https://releases.hashicorp.com/serf/0.7.0/serf_0.7.0_linux_amd64.zip \
 && unzip serf*.zip && mv serf /usr/bin/ && rm serf*.zip \
 && ln -sf /usr/local/openresty/luajit/bin/luajit /usr/local/bin/luajit \
 && cd /tmp && git clone https://github.com/Mashape/kong.git \
 && cd /tmp/kong \
 && git checkout $KONG_VERSION \
 && luarocks install kong-*.rockspec \
 && apk del build-dependencies \
 && apk add --no-cache \
    libpcrecpp libpcre16 libpcre32 openssl libssl1.0 pcre libgcc libstdc++ e2fsprogs-dev dnsmasq bash \
 && echo "user=root" >> /etc/dnsmasq.conf \
 && rm -rf "/tmp/"*

COPY etc/kong /etc/kong
COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/etc/kong"]

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8000 8443 8001 7946 7373
CMD ["kong", "start"]
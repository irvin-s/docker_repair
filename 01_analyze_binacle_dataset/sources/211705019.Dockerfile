FROM alpine:3.4

ARG KONG_VERSION

ENV KONG_VERSION=${KONG_VERSION:-0.9.1} \
    KONG_NGINX_DAEMON=off \
    PATH=/usr/local/openresty/bin:$PATH

RUN echo "==> Setting variables" \
    && OPENRESTY_PREFIX=/usr/local/openresty \
    && OPENRESTY_VERSION=1.9.15.1 \
    && LUAROCKS_VERSION=2.3.0 \
    && LUAJIT_VERSION=2.1.0-beta2 \
    && SERF_VERSION=0.7.0 \
    \
    && echo "==> Installing dependencies..." \
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
       -j${NPROC} \
    && echo "==> Building OpenResty..." \
    && make -j${NPROC} \
    && echo "==> Installing OpenResty..." \
    && make install \
    && echo "==> Configuring LuaRocks..." \
    && mkdir -p /tmp/luarocks \
    && cd /tmp/luarocks \
    && curl -sSL http://keplerproject.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz | tar -xz \
    && cd luarocks* \
    && ./configure \
       --with-lua=$OPENRESTY_PREFIX/luajit \
       --lua-suffix=jit-${LUAJIT_VERSION} \
       --with-lua-include=$OPENRESTY_PREFIX/luajit/include/luajit-2.1 \
    && echo "==> Building&Installing OpenResty..." \
    && make build && make install \
    \
    && echo "==> Installing kong dependencies..." \
    && apk add --no-cache libpcrecpp perl openssl dnsmasq \
    && echo "user=root" >> /etc/dnsmasq.conf \
    \
    && cd /tmp \
    && wget https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_linux_amd64.zip \
    && unzip serf*.zip && mv serf /usr/local/bin/ && rm serf*.zip \
    \
    && LUAROCKS_INSTALL="luarocks install" \
    && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/leafo/pgmoon-1.6.0-1.rockspec \
    && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/leafo/loadkit-1.1.0-1.rockspec \
    && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/luarocks/luasocket-3.0rc1-2.rockspec \
    && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/luarocks/lua-cjson-2.1.0-1.rockspec \
    && ${LUAROCKS_INSTALL} https://raw.githubusercontent.com/leafo/etlua/master/etlua-dev-1.rockspec \
    && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/leafo/lapis-1.5.1-1.rockspec \
    && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/luarocks/lualogging-1.3.0-1.rockspec \
    && ${LUAROCKS_INSTALL} https://luarocks.org/manifests/daurnimator/luatz-0.3-1.rockspec \
    \
    && echo "==> Installing kong..." \
    && cd /tmp && git clone https://github.com/Mashape/kong.git \
    && cd /tmp/kong \
    && git checkout $KONG_VERSION \
    && luarocks install kong-*.rockspec \
    && cp bin/kong /usr/local/bin \
    \
    && apk del build-dependencies \
    && rm -rf "/tmp/"*

EXPOSE 8000 8443 8001 7946 7373

VOLUME ["/etc/kong"]

ENTRYPOINT ["kong"]

CMD ["start"]
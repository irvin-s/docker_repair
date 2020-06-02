FROM openresty/openresty:1.11.2.1-alpine
MAINTAINER gavin zhou <gavin.zhou@gmail.com>

ENV LUAROCKS_VERSION=2.4.1 \
 KONG_VERSION=0.10.3 \
 SERF_VERSION=0.8.1 \
 OPENRESTY_PREFIX=/usr/local/openresty

RUN echo "==> Installing dependencies..." \
 && apk update \
 && apk add --virtual .build-deps \
    make gcc musl-dev curl wget git unzip openssl-dev \
 && apk add openssl dnsmasq perl \
 && apk add --upgrade gd busybox libxslt libxml2 \
 && apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/community dumb-init \
 && echo "==> Configuring LuaRocks..." \
 && mkdir -p /root/luarocks \
 && cd /root/luarocks \
 && curl -sSL http://keplerproject.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz |tar -xz \
 && cd luarocks* \
 && ./configure \
    --with-lua=$OPENRESTY_PREFIX/luajit \
    --lua-suffix=jit-2.1.0-beta2 \
    --with-lua-include=$OPENRESTY_PREFIX/luajit/include/luajit-2.1 \
 && make build && make install \
 && echo "==> Finishing..." \
 && echo "==> Installing kong dependencies..." \
 && wget -q https://releases.hashicorp.com/serf/${SERF_VERSION}/serf_${SERF_VERSION}_linux_amd64.zip \
 && unzip serf*.zip && mv serf /usr/bin/ && rm serf*.zip \
 && luarocks install https://raw.githubusercontent.com/Mashape/kong/${KONG_VERSION}/kong-${KONG_VERSION}-0.rockspec \
 && ln -sf $OPENRESTY_PREFIX/bin/resty /usr/local/bin/resty \
 && ln -sf $OPENRESTY_PREFIX/nginx/sbin/nginx /usr/local/bin/nginx \
 && curl -sSL -o /usr/local/bin/kong https://raw.githubusercontent.com/Mashape/kong/${KONG_VERSION}/bin/kong \
 && chmod +x /usr/local/bin/kong && mkdir -p /etc/kong \
 && curl -sSL -o /etc/kong/kong.conf.default https://raw.githubusercontent.com/Mashape/kong/${KONG_VERSION}/kong.conf.default \
 && apk del .build-deps \
 && echo "user=root" >> /etc/dnsmasq.conf \
 && rm -rf /var/cache/apk/* /root/luarocks

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 7946
CMD ["kong", "start"]

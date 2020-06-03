FROM openresty/openresty:jessie

RUN apt-get update && \
  apt-get install --no-install-recommends --no-install-suggests -y \
    gettext-base \
	&& rm -rf /var/lib/apt/lists/*

RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-jwt

COPY hugo-packet.lua member-files.lua /
COPY nginx.conf /nginx.conf.template
COPY favicon.ico hugo-admin.html index.html kansa-admin.html /srv/client/

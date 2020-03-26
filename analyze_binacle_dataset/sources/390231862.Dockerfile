#!/usr/bin/env docker

# Nginx/OpenResty (Sandbox) + LuaRocks
#
# VERSION               0.0.1
#
# BUILD:
#   docker build -t openresty-nginx-luarocks - < /vagrant/Dockerfile.openresty-luarocks
#
# RUN:
#   docker run -d -v /vagrant:/app -p 8080:8080 openresty-nginx-luarocks
#

FROM nginx-openresty
MAINTAINER Jonas Grimfelt <grimen@gmail.com>

## LUAROCKS
WORKDIR /tmp/
RUN wget http://luarocks.org/releases/luarocks-2.1.1.tar.gz
RUN tar -xzvf luarocks-2.1.1.tar.gz
WORKDIR /tmp/luarocks-2.1.1
RUN ./configure --lua-suffix=jit \
  --prefix=/usr/local/openresty/luajit \
  --with-lua=/usr/local/openresty/luajit \
  --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.0
RUN make build -j$(nproc) && make install

# DOCKER/LUAROCKS DIRTY-HACK - because home-dir is "/" and Luarocks don't handle that, don't ask how I came up with this "workaround"... >=|
RUN mkdir -p /usr/local/openresty/luajit/lib/luarocks/rocks \
  && mkdir -p /usr/local/openresty/luajit/lib//luarocks/rocks \
  && mkdir -p //.cache/luarocks/http___www.luarocks.org_repositories_rocks/ \
  && luarocks-admin make_manifest \
  && apt-get -q -y install unzip \
  && luarocks install md5 \
  && unzip //.cache/luarocks/http___www.luarocks.org_repositories_rocks/manifest-5.1.zip

# LUA DEPS
RUN luarocks install md5
RUN luarocks install lua-cjson
RUN luarocks install --server=http://rocks.moonscript.org magick

## LOCATE DB
RUN updatedb

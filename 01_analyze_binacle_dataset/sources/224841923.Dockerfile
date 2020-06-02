ARG NGINX_VERSION

FROM nginx:${NGINX_VERSION}-alpine

ARG NPS_VERSION
ARG PSOL_VERSION

MAINTAINER Alexey Zhokhov <alexey@zhokhov.com>

RUN set -ex \
	&& mkdir -p /usr/src \
    && cd /usr/src \
    && apk add --no-cache \
    		   tar \
    		   gzip \
    && GPG_KEYS=B0F4253373F8F6F510D42178520A9993A1C052F8 \
	&& apk add --no-cache --virtual .build-deps \
               apr-dev \
               apr-util-dev \
               build-base \
               ca-certificates \
               gd-dev \
               geoip-dev \
               git \
               gnupg \
               icu-dev \
               libjpeg-turbo-dev \
               libpng-dev \
               libxslt-dev \
               linux-headers \
               libressl-dev \
               pcre-dev \
               tar \
               zlib-dev \
	&& wget https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz -O nginx.tar.gz \
	&& wget https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz.asc -O nginx.tar.gz.asc \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& found=''; \
	for server in \
		ha.pool.sks-keyservers.net \
		hkp://keyserver.ubuntu.com:80 \
		hkp://p80.pool.sks-keyservers.net:80 \
		pgp.mit.edu \
	; do \
		echo "Fetching GPG key $GPG_KEYS from $server"; \
		gpg --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$GPG_KEYS" && found=yes && break; \
	done; \
	test -z "$found" && echo >&2 "error: failed to fetch GPG key $GPG_KEYS" && exit 1; \
	gpg --batch --verify nginx.tar.gz.asc nginx.tar.gz \
	&& rm -rf "$GNUPGHOME" nginx.tar.gz.asc \
	&& tar -zxC /usr/src -f nginx.tar.gz \
	&& rm nginx.tar.gz \
    && wget https://github.com/apache/incubator-pagespeed-ngx/archive/v${NPS_VERSION}.zip -O nps.zip \
	&& unzip nps.zip \
	&& rm nps.zip \
    && nps_dir=$(find . -name "*pagespeed-ngx-${NPS_VERSION}" -type d) \
    && cd "$nps_dir" \
    && wget https://github.com/donbeave/docker-nginx-pagespeed-psol/releases/download/v${PSOL_VERSION}-nginx-${NGINX_VERSION}-alpine/psol.tar.gz -O psol.tar.gz \
    && tar -xzf psol.tar.gz \
    && rm psol.tar.gz \
    && cd /usr/src/nginx-$NGINX_VERSION \
    && uname -a \
    && ./configure --add-dynamic-module=../incubator-pagespeed-ngx-${NPS_VERSION} \
                   --modules-path=/usr/lib/nginx/modules \
                   --with-compat \
                   --with-ld-opt="-Wl,-z,relro,--start-group -lapr-1 -laprutil-1 -licudata -licuuc -lpng -lturbojpeg -ljpeg" \
    && make modules \
    && cp objs/ngx_pagespeed.so /usr/lib/nginx/modules \
    && rm -rf /usr/src/* \
    && apk del .build-deps \
    && apk del tar \
               gzip \
    && apk add --no-cache \
               --update \
               g++ \
               apr \
               apr-util \
               icu-libs

COPY nginx.conf /etc/nginx/nginx.conf

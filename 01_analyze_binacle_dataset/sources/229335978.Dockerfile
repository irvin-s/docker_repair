FROM scf37/base

ENV NGINX_VERSION 1.15.9
ENV OPENSSL_VERSION 1.1.1b
ENV PCRE_VERSION 8.41
ENV ZLIB_VERSION 1.2.11

# ngx_brotli Sep 3 2018 (add ubuntu 18.04 libbrotli-dev path)
# Brotli 1.0.7
ENV NGX_BROTLI_VERSION 8104036af9cff4b1d34f22d00ba857e2a93a243c
ENV BROTLI_VERSION d6d98957ca8ccb1ef45922e978bb10efca0ea541

RUN cd /opt && \
    wget https://github.com/eustas/ngx_brotli/archive/$NGX_BROTLI_VERSION.zip -O ngx_brotli.zip && \
    wget https://github.com/google/brotli/archive/$BROTLI_VERSION.zip -O brotli.zip && \
    unzip ngx_brotli.zip && \
    unzip brotli.zip && \
    mv ngx_brotli-$NGX_BROTLI_VERSION ngx_brotli && \
    mv brotli-$BROTLI_VERSION/* ngx_brotli/deps/brotli && \
    apt-get update && \
    apt-get install -y make g++ libssl-dev libxslt-dev libgd2-xpm-dev libgeoip-dev libpam-dev && \
    cd /opt && \
    wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz && \
    tar xfz nginx-$NGINX_VERSION.tar.gz && \
    wget http://zlib.net/zlib-$ZLIB_VERSION.tar.gz && \
    tar xfz zlib-$ZLIB_VERSION.tar.gz && \
    wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-$PCRE_VERSION.tar.bz2 && \
    tar xfj pcre-$PCRE_VERSION.tar.bz2 && \
    wget https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz && \
    tar xfz openssl-$OPENSSL_VERSION.tar.gz && \
    cd /opt/nginx-$NGINX_VERSION && \
    ./configure --with-http_v2_module \
	--conf-path=/etc/nginx/nginx.conf \
	--with-zlib=../zlib-$ZLIB_VERSION \
	--with-pcre=../pcre-$PCRE_VERSION \
	--with-openssl=../openssl-$OPENSSL_VERSION \
	--with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' \
	--with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro' \
	--prefix=/usr/share/nginx \
	--conf-path=/etc/nginx/nginx.conf \
	--http-log-path=/var/log/nginx/access.log \
	--error-log-path=/var/log/nginx/error.log \
	--lock-path=/var/lock/nginx.lock \
	--pid-path=/run/nginx.pid \
	--http-client-body-temp-path=/var/lib/nginx/body \
	--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
	--http-proxy-temp-path=/var/lib/nginx/proxy \
	--http-scgi-temp-path=/var/lib/nginx/scgi \
	--http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
	--with-debug \
	--with-pcre-jit \
	--with-ipv6 \
	--with-http_ssl_module \
	--with-http_stub_status_module \
	--with-http_realip_module \
	--with-http_addition_module \
	--with-http_dav_module \
	--with-http_geoip_module \
	--with-http_gzip_static_module \
	--with-http_image_filter_module \
	--with-http_sub_module \
	--with-http_xslt_module \
	--with-mail \
	--with-mail_ssl_module \
	--add-module=../ngx_brotli && \
    make && \
    make install && \
    mkdir -p /var/lib/nginx/ && \
    mkdir -p /var/log/nginx/ && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    apt-get remove -y make g++ && \
    #remove artifacts not covered by previous command (for some reasons)
    apt-get remove -y cpp-4.8 gcc-4.8 manpages manpages-dev && \
    apt-get autoremove -y && \
    find /usr/lib -name "*.a" -exec rm -rf {} \; && \
    rm -rf /usr/include && \
    rm -rf /usr/share/doc && \
    rm -rf /usr/share/man && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /opt/*

COPY ./start.sh /start.sh
COPY conf /opt/conf

ENTRYPOINT ["/start.sh"]

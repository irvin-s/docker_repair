FROM unocha/alpine-base-s6:%%UPSTREAM%%

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# based on ideas by: orakili <docker@orakili.net>
# and: Pavel Litvinenko <gerasim13@gmail.com>
# and: Adrian B. Danieli "https://github.com/sickp"

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

ENV NGINX_VERSION nginx-${VERSION}
ENV NGINX_UPLOADPROGRESS_VERSION master-HEAD

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="alpine-base-nginx-extras" \
      org.label-schema.description="This service provides a base nginx platform with uploadprogress module." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.6" \
      info.humanitarianresponse.nginx=$VERSION \
      info.humanitarianresponse.nginx.modules="ssl realip addition sub sav flv mp4 gunzip gzip_static random_index secure_link stub_status auth_request threads stream ssl slice file-aio http_v2 uploadprogress" \
      info.humanitarianresponse.nginx.uploadprogress=$NGINX_UPLOADPROGRESS_VERSION

RUN build_pkgs="build-base git linux-headers openssl-dev pcre-dev wget zlib-dev" \
  && runtime_pkgs="ca-certificates openssl pcre zlib" \
  && apk add --update-cache ${build_pkgs} ${runtime_pkgs} \
  && cd /tmp \
  && git clone https://github.com/masterzen/nginx-upload-progress-module.git /tmp/nginx-upload-progress-module-${NGINX_UPLOADPROGRESS_VERSION} \
  && wget http://nginx.org/download/${NGINX_VERSION}.tar.gz \
  && tar xzf ${NGINX_VERSION}.tar.gz \
  && cd /tmp/${NGINX_VERSION} \
  && ./configure \
    --prefix=/etc/nginx \
    --sbin-path=/usr/sbin/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --user=nginx \
    --group=nginx \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_stub_status_module \
    --with-http_auth_request_module \
    --with-threads \
    --with-stream \
    --with-stream_ssl_module \
    --with-http_slice_module \
    --with-file-aio \
    --with-http_v2_module \
    --add-module=/tmp/nginx-upload-progress-module-${NGINX_UPLOADPROGRESS_VERSION} \
  && make \
  && make install \
  && sed -i -e 's/#access_log  logs\/access.log  main;/access_log \/dev\/stdout;/' -e 's/#error_log  logs\/error.log  notice;/error_log stderr notice;/' /etc/nginx/nginx.conf \
  && adduser -D nginx \
  && rm -rf /tmp/* \
  && apk del ${build_pkgs} \
  && rm -rf /var/cache/apk/* \
  && nginx -V

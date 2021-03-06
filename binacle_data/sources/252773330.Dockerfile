FROM janeczku/alpine-kubernetes:3.2  
# ORIGINAL MAINTAINER John Allen <john.allen@connexiolabs.com>  
# ORIGINAL MAINTAINER Emmanuel Frecon <efrecon@gmail.com>  
MAINTAINER Sam Grimee <sgrimee@gmail.com>  
  
ENV NGINX_VERSION nginx-1.9.9  
RUN apk --update add openssl-dev pcre-dev zlib-dev wget build-base && \  
mkdir -p /tmp/src && \  
cd /tmp/src && \  
wget http://nginx.org/download/${NGINX_VERSION}.tar.gz && \  
tar -zxvf ${NGINX_VERSION}.tar.gz && \  
cd /tmp/src/${NGINX_VERSION} && \  
./configure \  
\--with-http_ssl_module \  
\--with-http_gzip_static_module \  
\--with-http_stub_status_module \  
\--prefix=/etc/nginx \  
\--http-log-path=/var/log/nginx/access.log \  
\--error-log-path=/var/log/nginx/error.log \  
\--sbin-path=/usr/local/sbin/nginx && \  
make && \  
make install && \  
apk del build-base && \  
rm -rf /tmp/src && \  
rm -rf /var/cache/apk/*  
  
# forward request and error logs to docker log collector  
RUN ln -sf /dev/stdout /var/log/nginx/access.log  
RUN ln -sf /dev/stderr /var/log/nginx/error.log  
  
VOLUME ["/var/log/nginx"]  
  
WORKDIR /etc/nginx  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]  


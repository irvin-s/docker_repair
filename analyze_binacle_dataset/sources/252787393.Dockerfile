FROM alpine:latest  
MAINTAINER Oleg Gumbar <brightside@fonline-status.ru>  
  
ENV NGINX_VERSION 1.11.3  
  
RUN apk update && \  
apk add \  
git \  
gcc \  
binutils-libs \  
binutils \  
gmp \  
isl \  
libgomp \  
libatomic \  
libgcc \  
openssl \  
pkgconf \  
pkgconfig \  
mpfr3 \  
mpc1 \  
libstdc++ \  
ca-certificates \  
libssh2 \  
curl \  
expat \  
pcre \  
musl-dev \  
libc-dev \  
pcre-dev \  
zlib-dev \  
openssl-dev \  
make  
  
RUN cd /tmp/ && \  
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \  
git clone https://github.com/arut/nginx-rtmp-module.git && \  
cd nginx-rtmp-module && \  
git checkout v1.1.9 && \  
cd ..  
  
RUN cd /tmp && \  
tar xzf nginx-${NGINX_VERSION}.tar.gz && \  
cd nginx-${NGINX_VERSION} && \  
./configure \  
\--prefix=/opt/nginx \  
\--with-http_ssl_module \  
\--add-module=../nginx-rtmp-module && \  
make && \  
make install  
  
RUN echo "rtmp {" >> /opt/nginx/conf/nginx.conf && \  
echo " server {" >> /opt/nginx/conf/nginx.conf && \  
echo " listen 1935;" >> /opt/nginx/conf/nginx.conf && \  
echo " chunk_size 4096;" >> /opt/nginx/conf/nginx.conf && \  
echo " application live {" >> /opt/nginx/conf/nginx.conf && \  
echo " live on;" >> /opt/nginx/conf/nginx.conf && \  
echo " record off;" >> /opt/nginx/conf/nginx.conf && \  
echo " }" >> /opt/nginx/conf/nginx.conf && \  
echo " application testing {" >> /opt/nginx/conf/nginx.conf && \  
echo " live on;" >> /opt/nginx/conf/nginx.conf && \  
echo " record off;" >> /opt/nginx/conf/nginx.conf && \  
echo " }" >> /opt/nginx/conf/nginx.conf && \  
echo " }" >> /opt/nginx/conf/nginx.conf && \  
echo "}" >> /opt/nginx/conf/nginx.conf  
  
  
EXPOSE 1935  
EXPOSE 8080  
  
CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]  


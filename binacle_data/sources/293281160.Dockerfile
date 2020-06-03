FROM centos:latest
MAINTAINER lemon lemon616@outlook.com

ENV TZ "Asia/Shanghai"

#yum
RUN yum -y update && \
    yum install -y gcc automake autoconf libtool make gcc-c++ vixie-cron  wget zlib  file openssl-devel sharutils zip  bash vim cyrus-sasl-devel libmemcached libmemcached-devel libyaml libyaml-devel unzip libvpx-devel openssl-devel ImageMagick-devel  autoconf  tar gcc libxml2-devel gd-devel libmcrypt-devel libmcrypt mcrypt mhash libmcrypt libmcrypt-devel libxml2 libxml2-devel bzip2 bzip2-devel curl curl-devel libjpeg libjpeg-devel libpng libpng-devel freetype-devel bison libtool-ltdl-devel net-tools && \
    yum clean all

#install nginx
RUN cd /tmp && \
    wget http://nginx.org/download/nginx-1.13.0.tar.gz && \
    tar xzf nginx-1.13.0.tar.gz && \
    cd /tmp/nginx-1.13.0 && \
    ./configure \
    --prefix=/usr/local/nginx \
    --with-http_ssl_module --with-http_sub_module --with-http_dav_module --with-http_flv_module \
    --with-http_gzip_static_module --with-http_stub_status_module --with-debug && \
    make && \
    make install

EXPOSE 80 443

#启动nginx
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]

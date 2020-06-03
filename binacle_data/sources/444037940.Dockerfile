FROM centos:centos6

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-08-21
ENV NGINX_VERSION 1.6.1

RUN yum install -y https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# Without centosplus, you will get multilib problems when installing openssl-devel
RUN yum install -y --enablerepo=centosplus tar git make gcc pcre-devel openssl-devel python-setuptools python-devel wget inotify-tools

# Install nginx and modules (if any)
# To install modules, dowonload them (example via git clone), and add "--add-module=./module-path/" to ./configure
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar -zxvf nginx-${NGINX_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    ./configure --with-http_ssl_module --with-http_sub_module --with-http_spdy_module --user=www-data --group=www-data --prefix=/usr/local/nginx/ --sbin-path=/usr/local/sbin && \
    make && make install && touch /usr/local/nginx/conf/generated.conf
ADD nginx.conf /usr/local/nginx/conf/nginx.conf
RUN adduser --system www-data

ADD start /start
RUN chmod 755 /start
ENTRYPOINT ["/bin/bash", "-e", "/start"]
CMD ["start"]

EXPOSE 80
EXPOSE 443

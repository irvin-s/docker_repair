# python环境，v1, nginx, php-fpm7
FROM centos:7

MAINTAINER yubang（yubang93@gmail.com）

RUN yum install epel-release -y
RUN yum install nginx -y

RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm && \
yum install -y php71w-fpm && \
yum install -y php71w-pdo && \
yum install -y php71w-pecl-memcached && \
yum install -y php71w-mysqlnd && \
yum install -y php71w-mbstring && \
yum install -y php71w-pecl-redis && \
yum install -y php71w-gd && \
yum install -y php71w-pecl-imagick

ADD nginx.conf /etc/nginx/nginx.conf
ADD install.sh /var/install.sh
ADD start.sh /var/start.sh

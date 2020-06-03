# python环境，v1, nginx, nodejs
FROM centos:7

MAINTAINER yubang（yubang93@gmail.com）

RUN yum install epel-release -y
RUN yum install nginx -y

RUN yum install ruby -y
RUN gem install bundler

ADD nginx.conf /etc/nginx/nginx.conf
ADD install.sh /var/install.sh
ADD start.sh /var/start.sh

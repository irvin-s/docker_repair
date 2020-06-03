FROM centos:7

MAINTAINER yubang（yubang93@gmail.com ）

RUN yum install epel-release -y
RUN yum install nginx -y
ADD nginx.conf /etc/nginx/nginx.conf
ADD start.sh /var/start.sh

# python环境，v1, nginx, java8, tomcat7
FROM centos:7

MAINTAINER yubang（yubang93@gmail.com）

RUN yum install epel-release -y
RUN yum install nginx -y

RUN yum install -y java-1.8.0-openjdk && \
yum install -y tomcat

ADD nginx.conf /etc/nginx/nginx.conf
ADD install.sh /var/install.sh
ADD start.sh /var/start.sh

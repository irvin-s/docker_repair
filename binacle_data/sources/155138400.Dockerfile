# python环境，v1, nginx, python3.4.5
FROM centos:7

MAINTAINER yubang（yubang93@gmail.com）

RUN yum install epel-release -y
RUN yum install nginx -y

RUN yum -y install mysql-devel
RUN yum install python34-pip -y
RUN mkdir -v ~/.pip && echo -e "[global]\ntimeout = 60\nindex-url = https://pypi.douban.com/simple" > ~/.pip/pip.conf
RUN pip3 install gunicorn
RUN pip3 install gevent

ADD nginx.conf /etc/nginx/nginx.conf
ADD install.sh /var/install.sh
ADD start.sh /var/start.sh

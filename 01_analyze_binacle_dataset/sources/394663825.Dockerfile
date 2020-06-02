FROM centos:centos6

MAINTAINER Felipe Bessa Coelho, fcoelho.9@gmail.com

RUN yum install -y http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
RUN yum install -y nginx
RUN rm -rf /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/nginx.conf
ADD run.sh /run.sh

VOLUME ["/etc/nginx/conf.d", "/var/log/nginx/"]

EXPOSE 80 443

CMD ["/run.sh"]


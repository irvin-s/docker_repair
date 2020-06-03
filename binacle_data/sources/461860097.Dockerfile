############################################################
# 创建openresty环境的dockerfile
# Based on Centos 6.8
############################################################
# Set the base image to centos
FROM centos:6.8
# File Author / Maintainer
MAINTAINER lvyalin lvyalin.yl@gmail.com

RUN yum install -y net-tools vsftpd vim wget crontabs gcc make openssh-server git && \
 service sshd start && \
 echo "root:Root1.pwd" | chpasswd && \
 yum clean all

RUN yum install -y yum-utils && \
    yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo && \
    yum install -y openresty && \
    ln -s /usr/local/openresty/nginx/conf /etc/nginx && \
    yum clean all

ADD conf/vhosts /etc/nginx/
ADD conf/gateway_http.conf /etc/nginx/
ADD conf/gateway_server.conf /etc/nginx/
ADD conf/nginx.conf /etc/nginx/
ADD conf/service_data.json /etc/nginx/
ADD lua /usr/local/openresty/nginx/

EXPOSE 80
EXPOSE 443

CMD /usr/local/openresty/nginx/sbin/nginx;/bin/bash
#
# MAINTAINER        Carson,C.J.Zeong <zcy@nicescale.com>
# DOCKER-VERSION    1.6.2
#
# Dockerizing CentOS7: Dockerfile for building CentOS images
#
FROM       index.alauda.cn/canyue/centos7_1
MAINTAINER Carson,C.J.Zeong <zcy@nicescale.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm

RUN yum install -y curl wget tar bzip2 unzip vim-enhanced passwd sudo yum-utils hostname net-tools rsync man
RUN yum install -y gcc gcc-c++ git make automake cmake patch logrotate python-devel libpng-devel libjpeg-devel
RUN yum install -y epel-release && \
    yum update -y && \
    yum install -y pwgen python-pip 

RUN yum clean all

RUN pip install supervisor
ADD supervisord.conf /etc/supervisord.conf

RUN mkdir -p /etc/supervisor.conf.d && \
    mkdir -p /var/log/supervisor

EXPOSE 22

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

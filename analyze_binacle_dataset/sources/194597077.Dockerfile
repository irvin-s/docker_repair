## Version: 0.3
FROM centos:centos6
MAINTAINER Anton Bugreev <anton@bugreev.ru>

## Install docker, cron
COPY docker.repo /etc/yum.repos.d/
RUN yum install docker-engine cronie git -y

## Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

## Set TZ
RUN cat /usr/share/zoneinfo/Asia/Tomsk > /etc/localtime

## Add cron jobs
COPY cron-jobs /var/spool/cron/root

## Set workdir
WORKDIR /root/docker-web-stack/

## Start service
CMD ["/usr/sbin/crond", "-n"]


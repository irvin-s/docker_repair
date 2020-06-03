FROM xeor/base:7.1-4

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2015-10-04
ENV NGINX_VERSION 1.6.3

RUN yum upgrade -y && yum install -y nginx wget tar python-setuptools && easy_install pip && pip install supervisor

RUN wget https://github.com/jwilder/docker-gen/releases/download/0.4.1/docker-gen-linux-amd64-0.4.1.tar.gz && \
    tar xvzf docker-gen-linux-amd64-0.4.1.tar.gz

ADD sites.tmpl /
ADD docker-gen.conf /
ADD nginx.conf /etc/nginx/nginx.conf

COPY init/ /init/
COPY supervisord.d/ /etc/supervisord.d/

ENV DOCKER_HOST unix:///docker.sock
EXPOSE 80

FROM xeor/base:7.1-4

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2015-02-07

RUN yum install -y nginx inotify-tools

COPY init/ /init/
COPY supervisord.d/ /etc/supervisord.d/
COPY nginx-global.conf /etc/nginx/nginx.conf

EXPOSE 80
EXPOSE 443

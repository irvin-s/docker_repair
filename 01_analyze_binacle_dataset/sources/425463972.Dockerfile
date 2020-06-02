FROM devopsil/base

ADD nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum install -y nginx \
    && yum clean all

EXPOSE 80 443

ENTRYPOINT [ "/usr/sbin/nginx", "-g daemon off;" ]

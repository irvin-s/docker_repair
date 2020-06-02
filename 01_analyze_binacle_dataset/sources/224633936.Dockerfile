FROM demoregistry.dataman-inc.com/library/centos7-base:latest
MAINTAINER jyliu jyliu@dataman-inc.com

#install nginx

COPY nginx.repo /etc/yum.repos.d/
RUN yum install -y nginx-1.8.0 && yum clean all

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

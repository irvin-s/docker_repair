FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum clean all; yum -y update; yum -y install httpd mod_ssl net-tools bash-completion vim wget iptables cronie; yum clean all

VOLUME /var/www/html

COPY httpd-rpm.sh /httpd-rpm.sh
RUN chmod +x /httpd-rpm.sh

ENTRYPOINT ["/httpd-rpm.sh"]

EXPOSE 80 443

CMD ["httpd", "-DFOREGROUND"]

# docker build -t httpd-rpm .
# docker run -d --restart always -p 10080:80 -p 10443:443 -v /docker/www:/var/www/html -e PHP_SERVER=redhat.xyz --hostname httpd --name httpd httpd-rpm
# docker run -it --rm httpd-rpm --help

FROM centos
MAINTAINER shin1x1 <shin1x1@gmail.com>

#
# httpd
RUN yum -y install httpd

#
# PHP
RUN yum -y install php

CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]

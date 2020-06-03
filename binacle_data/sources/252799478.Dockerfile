FROM centos  
MAINTAINER Anthony Tonns <anthony@tonns.com>  
RUN yum -y install httpd && yum clean all  
ADD bro.conf /etc/httpd/conf.d/bro.conf  
ADD bro.html /var/www/html/bro.html  
EXPOSE 80  
CMD rm -f /var/run/httpd/httpd.pid && /usr/sbin/httpd -DFOREGROUND  


FROM centos  
MAINTAINER d9magai  
RUN yum update -y && yum install -y epel-release && yum clean all  
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm  
RUN yum update -y && yum install -y \  
php70-php \  
&& yum clean all  
COPY index.php /var/www/html/index.php  
EXPOSE 80  
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]  


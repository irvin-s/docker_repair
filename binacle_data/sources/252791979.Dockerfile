FROM centos  
MAINTAINER chaoscosmos <chaoshi@gmail.com>  
RUN yum install httpd -y \  
&& yum install iproute -y  
RUN echo 'myapp v1' > /var/www/html/index.html  
EXPOSE 80  
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]  


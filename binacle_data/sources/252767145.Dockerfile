FROM centos  
MAINTAINER xiaoyan  
RUN yum install httpd -y  
RUN echo 'myapp v1' > /var/www/html/index.html  
EXPOSE 80  
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]  


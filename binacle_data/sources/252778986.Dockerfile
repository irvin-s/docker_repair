FROM centos  
MAINTAINER Burton  
RUN yum install httpd -y  
RUN echo 'dockerapp v2'> /var/www/html/index.html  
EXPOSE 80  
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]  


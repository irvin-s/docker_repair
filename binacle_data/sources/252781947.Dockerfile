FROM centos  
MAINTAINER John  
RUN yum install httpd -y  
RUN echo 'dockerapp v1' > /var/www/html/index.html  
EXPOSE 8080  
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]  


FROM centos  
RUN yum install httpd -y; yum clean all  
RUN echo 'AutoBuild v2' > /var/www/html/index.html  
EXPOSE 80  
CMD /usr/sbin/httpd -D FOREGROUND  


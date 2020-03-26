FROM centos:latest  
  
MAINTAINER 0.1 your-name@domain  
  
  
RUN ["yum","-y","install","httpd"]  
  
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]  


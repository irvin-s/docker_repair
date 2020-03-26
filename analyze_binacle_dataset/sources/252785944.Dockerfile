FROM centos:latest  
  
MAINTAINER djpaek  
  
RUN ["yum","-y", "install","httpd"]  
  
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]  


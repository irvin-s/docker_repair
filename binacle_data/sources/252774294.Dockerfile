FROM centos:centos6  
MAINTAINER ameerhamza810@gmail.com  
  
RUN yum -y update; yum clean all  
RUN yum -y install httpd  
  
ADD . /var/www/html  
  
EXPOSE 80  
RUN echo "/sbin/service httpd start" >> /root/.bashrc  


FROM centos:centos6  
  
MAINTAINER coleman <coleman_dlut@hotmail.com>  
  
#*************************  
#* Update and Pre-Reqs *  
#*************************  
RUN yum -y update && yum -y install mysql-server && yum clean all  
  
VOLUME ["/etc/mysql", "/var/lib/mysql"]  
  
EXPOSE 3306  
CMD ["/usr/bin/mysqld_safe"]  


FROM centos:centos6  
  
RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm  
  
RUN yum -y install epel-release; yum clean all  
RUN yum -y update; yum clean all  
RUN yum -y install mysql55w-server; yum clean all  
  
ADD my.cnf /etc/mysql/conf.d/my.cnf  
RUN chmod 664 /etc/mysql/conf.d/my.cnf  
ADD run /usr/local/bin/run  
RUN chmod +x /usr/local/bin/run  
  
VOLUME ["/var/lib/mysql"]  
EXPOSE 3306  
CMD ["/usr/local/bin/run"]


FROM mysql:5.7.11  
# Allow storing the data in some data-only docker container  
VOLUME /var/lib/mysql  
  
COPY sage.cnf /etc/mysql/conf.d/sage.cnf  
ENV MYSQL_USER sageadmin  


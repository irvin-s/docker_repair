FROM conyac/base:latest  
  
RUN apt-get update && apt-get -y install mysql-server-5.6 pwgen  
  
RUN rm -rf /var/lib/mysql/*  
  
ADD my.cnf /etc/mysql/my.cnf  
ADD create_admin.sh /create_admin.sh  
ADD run.sh /run.sh  
VOLUME ["/etc/mysql", "/var/lib/mysql"]  
  
EXPOSE 3306  
CMD ["/run.sh"]  
  


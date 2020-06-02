FROM mysql:5.7  
MAINTAINER Anoop Macharla <149@holbertonschool.com>  
  
# tell the container what port will be using  
EXPOSE 3306  
# Custom mysql config  
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf  
  
# Setup data base config file  
COPY dbsetup.sql /docker-entrypoint-initdb.d/dbsetup.sql  


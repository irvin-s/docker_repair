FROM mysql:5.7  
COPY local.cnf /etc/mysql/conf.d/  
  
RUN /etc/init.d/mysql start && \  
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE cube43" && \  
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE cube43_test"  
  
EXPOSE 3306


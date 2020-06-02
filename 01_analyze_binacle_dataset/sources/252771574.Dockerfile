FROM asterios/mysql-slave-noinno  
  
# Replication Slave  
RUN echo [mysqld] > /etc/mysql/conf.d/rep-login.cnf \  
&& echo replicate-ignore-db = static >> /etc/mysql/conf.d/rep-login.cnf  


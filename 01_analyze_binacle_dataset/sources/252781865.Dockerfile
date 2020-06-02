FROM mysql:5.7  
  
RUN { \  
echo "[mysqld]"; \  
echo "datadir=/var/lib/db-data"; \  
} > /etc/mysql/conf.d/my.cnf  
  
ADD data.tar.gz /var/lib/db-data  


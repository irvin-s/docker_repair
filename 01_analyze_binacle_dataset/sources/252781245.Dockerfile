FROM mysql:5.7  
  
COPY mysql-utf8mb4.cnf /etc/mysql/conf.d/mysql-utf8mb4.cnf  
COPY mysql-sqlmode.cnf /etc/mysql/conf.d/mysql-sqlmode.cnf  


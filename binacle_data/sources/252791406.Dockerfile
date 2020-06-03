# Tune innodb_buffer_pool_size  
# Based on mysql:latest  
FROM mysql:latest  
MAINTAINER Stanislav Osipov <stanislav.osipov@jetbrains.com>  
RUN echo "[mysqld]" >> /etc/mysql/my.cnf  
RUN echo "innodb_buffer_pool_size=1G" >> /etc/mysql/my.cnf  


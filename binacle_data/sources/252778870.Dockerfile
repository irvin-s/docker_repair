FROM mysql:5.6  
# Fixes issues with docker exec  
# See https://github.com/dockerfile/mariadb/issues/3  
RUN echo "export TERM=xterm" >> ~/.bashrc  
  
# Custom MySQL configuration  
COPY mysqld.cnf /etc/mysql/mysql.conf.d/001mysqld.cnf


FROM mysql:latest  
MAINTAINER Alan Peng <alan_peng@wise2.com>  
COPY sql-init.sh /docker-entrypoint-initdb.d/  
COPY entrypoint.sh /usr/local/bin/docker-entrypoint.sh  
COPY my-master.cnf /etc/  
COPY my-slave.cnf /etc/  
COPY my-slave2.cnf /etc/  


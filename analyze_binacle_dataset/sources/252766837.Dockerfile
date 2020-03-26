FROM mysql:5.7  
MAINTAINER Alan Peng <alan_peng@wise2.com>  
COPY sql-init.sh /docker-entrypoint-initdb.d/  
COPY update-config.sh /usr/local/bin/update-config.sh  
COPY entrypoint.sh /usr/local/bin/docker-entrypoint.sh  
COPY my-master.cnf /etc/  
COPY my-slave1.cnf /etc/  
COPY my-slave2.cnf /etc/  
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \  
chmod +x /docker-entrypoint-initdb.d/sql-init.sh && \  
chmod +x /usr/local/bin/update-config.sh  


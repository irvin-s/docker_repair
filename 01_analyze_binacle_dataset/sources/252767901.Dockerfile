FROM mariadb:10.1  
MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"  
EXPOSE 3306 4444 4567 4567/udp 4568  
ADD ./conf/cluster.cnf /etc/mysql/conf.d/cluster.cnf  
ADD ./scripts/mariadb-entrypoint.sh /usr/local/bin/mariadb-entrypoint.sh  
  
ENTRYPOINT ["mariadb-entrypoint.sh"]  
CMD ["mysqld"]  


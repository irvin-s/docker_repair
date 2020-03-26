# Version 1.0.0  
FROM mysql:5.5  
MAINTAINER Berti Golf <info@berti-golf.de>  
ENV MYSQL_ROOT_PASSWORD neosrootpass  
ENV MYSQL_USER neos  
ENV MYSQL_PASSWORD NeosDockerPass  
ENV MYSQL_DATABASE neos  
  
ENTRYPOINT ["/entrypoint.sh"]  
EXPOSE 3306  
CMD ["mysqld", "--datadir=/var/lib/mysql", "--user=mysql"]


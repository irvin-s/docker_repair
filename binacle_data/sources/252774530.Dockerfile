  
# Builds a docker gui image  
FROM mariadb:10.1  
  
MAINTAINER an0t8  
RUN \  
  
# Install python-mysqldb  
apt-get update && \  
apt-get install -y python-mysqldb && \  
  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
VOLUME /var/lib/mysql  
EXPOSE 3306  
  
ENTRYPOINT ["docker-entrypoint.sh"]  
CMD ["mysqld"]  


FROM mysql:8.0  
# Docksal settings  
COPY default.cnf /etc/mysql/conf.d/10-default.cnf  
  
VOLUME /var/lib/mysql  
  
COPY docker-entrypoint.sh /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
  
EXPOSE 3306  
CMD ["mysqld"]  


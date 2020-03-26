FROM mysql:5.7  
ENV \  
REPLICATOR_USERNAME=replicator \  
REPLICATOR_PASSWORD=password \  
MASTER_HOST=mysql-master.tld \  
MASTER_PORT=3306 \  
LOG_BIN=log-bin \  
RELAY_LOG=relay-bin  
  
COPY container/* /  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["mysqld"]  


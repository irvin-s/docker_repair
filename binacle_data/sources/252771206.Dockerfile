FROM mysql:5.7  
ENV REPLICATION_USER replication  
  
ENV REPLICATION_PASSWORD replication_pass  
  
RUN apt-get update && apt-get install -y vim python cron bzip2  
  
COPY replication-entrypoint.sh /usr/local/bin/  
  
COPY init-slave.sh /  
  
COPY init-master.sh /  
  
COPY mysql_options.py /usr/local/bin/  
  
COPY mysql_backup.sh /usr/local/bin/  
  
ENTRYPOINT ["replication-entrypoint.sh"]  
  
CMD ["mysqld"]


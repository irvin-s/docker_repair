FROM postgres:9.5.1  
  
ADD ./data_backup.tar.gz /var/lib/postgresql/data  


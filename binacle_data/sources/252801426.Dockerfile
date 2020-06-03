FROM postgres:9.4  
  
RUN apt-get update && apt-get install -q -y awscli  
  
ADD report-backup.sh /report-backup.sh  
ADD db-backup.sh /db-backup.sh  
ADD restore-database.sh /restore-database.sh


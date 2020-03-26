FROM ubuntu:latest  
  
MAINTAINER Björn Heneka <bheneka@codebee.de>  
  
RUN apt-get update && apt-get install -y rsync vim cron  
  
ADD backup.sh /backup.sh  
ADD backup_jenkins /etc/cron.d/backup_jenkins  
  
RUN chmod 0644 /etc/cron.d/backup_jenkins && \  
touch /var/log/cron.log  
  
CMD cron && tail -f /var/log/cron.log


FROM mongo:latest  
  
# Install cron  
RUN apt-get update  
RUN apt-get install -y cron  
  
# Add crontab file and shell script  
ADD mongo-backup.cron /etc/cron.d/mongo-backup  
ADD mongo-backup.sh /mongo-backup.sh  
  
RUN chmod +x /mongo-backup.sh  
RUN chmod 0644 /etc/cron.d/mongo-backup  
  
RUN touch /var/log/backup.log  
  
# Run the command on container startup  
CMD cron && touch /etc/cron.d/mongo-backup && tail -f /dev/null  


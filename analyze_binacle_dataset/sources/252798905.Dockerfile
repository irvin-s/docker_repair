FROM devialab/docker-postgres-wale  
  
RUN pip install awscli  
  
ADD crontab/dump /etc/cron.d/dump  
RUN chmod 0644 /etc/cron.d/dump


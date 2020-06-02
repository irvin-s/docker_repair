FROM ubuntu:16.04  
RUN apt-get update && apt-get install -y cron logrotate curl  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get install -y nodejs  
  
RUN mkdir -p /usr/src/app  
  
COPY ./templates/log-rotation /etc/logrotate.d/my-cron-job  
  
COPY ./templates/crontab /tmp/crontab  
  
RUN touch /etc/cron.d/my-cron-job  
RUN chmod 0644 /etc/cron.d/my-cron-job  
RUN touch /var/log/cron.log  
  
COPY ./templates/setupCron.sh /tmp/setupCron.sh  
RUN chmod +x /tmp/setupCron.sh  
  
CMD ["/tmp/setupCron.sh"]  


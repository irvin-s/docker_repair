FROM dobrovoz/php-fpm  
  
VOLUME /var/log/  
  
RUN apt-get update && apt-get install -y cron \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ADD crontab /etc/cron.d/crontab  
  
RUN chmod 0644 /etc/cron.d/crontab  
  
CMD touch /var/log/cron.log && cron && tail -f /var/log/cron.log


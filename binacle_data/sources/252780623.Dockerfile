FROM copex/php  
  
RUN rm -rf /etc/my_init.d/*  
  
COPY cron.sh /etc/my_init.d/cron.sh  
RUN chmod +x /etc/my_init.d/cron.sh


  
FROM phusion/baseimage:0.9.16  
MAINTAINER aptalca  
  
VOLUME ["/config"]  
  
# Add dynamic dns script  
ADD duck.sh /root/duckdns/duck.sh  
  
RUN chmod +x /root/duckdns/duck.sh && \  
mkdir -p /etc/my_init.d  
  
ADD firstrun.sh /etc/my_init.d/firstrun.sh  
ADD duckcron.conf /root/duckdns/duckcron.conf  
  
RUN chmod +x /etc/my_init.d/firstrun.sh && \  
crontab /root/duckdns/duckcron.conf  
  
RUN cron  


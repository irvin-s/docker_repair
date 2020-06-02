FROM mongo:latest  
MAINTAINER Alexandre Ferland <aferlandqc@gmail.com>  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
cron \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD backup.sh /backup.sh  
ADD start.sh /start.sh  
RUN chmod +x /start.sh && chmod +x /backup.sh  
  
VOLUME /backup  
VOLUME /var/log  
  
ENTRYPOINT ["/start.sh"]  
  


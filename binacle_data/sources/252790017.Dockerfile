FROM mongo  
MAINTAINER Herve Bredin <bredin@limsi.fr>  
  
RUN apt-get update && \  
apt-get install -y cron lftp && \  
rm -rf /var/lib/apt/lists/*  
  
ADD backup.sh /backup.sh  
RUN chmod +x /backup.sh  
  
ADD start.sh /start.sh  
RUN chmod +x /start.sh  
  
CMD '/start.sh'  


FROM debian:jessie  
MAINTAINER Tomasz Rzany <tomasz.rzany@amsterdam-standard.pl>  
  
RUN apt-get update && \  
apt-get install -y python python-pip cron openssl rsync && \  
rm -rf /var/lib/apt/lists/*  
  
RUN pip install s3cmd  
  
ADD s3cfg /root/.s3cfg  
  
ADD start.sh /start.sh  
RUN chmod +x /start.sh  
  
ADD restore.sh /restore.sh  
RUN chmod +x /restore.sh  
  
ADD backup.sh /backup.sh  
RUN chmod +x /backup.sh  
  
ENTRYPOINT ["/start.sh"]  
VOLUME ["/opt/restore", "/opt/copy"]  
  
CMD [""]  


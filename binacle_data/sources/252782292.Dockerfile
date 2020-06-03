FROM python:alpine  
  
RUN apk update && apk add less  
RUN pip install rotate-backups  
RUN mkdir /data  
COPY rotate-backups-in-data.sh /opt/rotate-backups-in-data.sh  
RUN chmod +x /opt/rotate-backups-in-data.sh  
ENTRYPOINT ["/opt/rotate-backups-in-data.sh"]  
CMD ["--help"]  


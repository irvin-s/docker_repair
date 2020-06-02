FROM postgres:9.4  
RUN mkdir /backup  
  
ENV CRON_TIME="0 0 * * *" \  
MYSQL_DB="--all-databases"  
ADD run.sh /run.sh  
VOLUME ["/backup"]  
  
CMD ["/run.sh"]  
  


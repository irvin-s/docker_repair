FROM python:2.7-alpine  
  
ENV S3CMD_VERSION=1.6.1  
RUN pip install --no-cache-dir s3cmd==$S3CMD_VERSION  
  
COPY files/.s3cfg /root/.s3cfg  
COPY files/start.sh /bin/start.sh  
  
ENTRYPOINT ["start.sh"]  


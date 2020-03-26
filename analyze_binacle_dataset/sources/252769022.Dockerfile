FROM andronics/debian  
  
LABEL author="andronics <andronics@gmail.com>"  
LABEL description="Backup and restore MySQL \ MariaDB using S3 storage"  
LABEL version="1.0"  
  
RUN apt-get update && \  
apt-get install -y s3cmd mysql-client cron && \  
apt-get clean  
  
# clean up  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY rootfs/ /  
  
ENTRYPOINT ['/init']  


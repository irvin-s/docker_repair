FROM mongo:3.4.2  
RUN set -x \  
&& apt-get update \  
&& apt-get install -y \  
nfs-common \  
wget \  
cron \  
  
&& rm -rf /var/lib/apt/lists/*  
  
  
ENV S3CMD_VERSION 1.6.1  
ADD install.sh install.sh  
RUN chmod +x install.sh  
RUN sh install.sh && rm install.sh  
  
COPY entry.sh /entry.sh  
RUN chmod +x /entry.sh  
  
COPY backup_and_upload /etc/cron.weekly/backup_and_upload  
RUN chmod +x /etc/cron.weekly/backup_and_upload  
  
ENTRYPOINT ["/entry.sh"]  
  


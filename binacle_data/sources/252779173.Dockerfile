FROM ruby:2.3-alpine  
MAINTAINER ByS Control "info@bys-control.com.ar"  
# Instalo gemas para manejo de backups  
RUN apk add --update build-base openssl tar && \  
gem install whenever backup && \  
apk del build-base && \  
rm -rf /var/cache/apk/* && \  
mkdir -p /root/Backup/log  
  
CMD crond -b -d 8 && \  
touch /root/Backup/log/backup.log && \  
tail -f /root/Backup/log/backup.log  


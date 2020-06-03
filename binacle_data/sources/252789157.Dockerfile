FROM ubuntu  
  
MAINTAINER Dirk Steinkopf "https://github.com/dsteinkopf"  
ENV BACKUP_INTERVAL=86400 \  
BACKUP_FIRSTDELAY=0 \  
MYSQLDUMP_ADD_OPTS= \  
MYSQL_CONNECTION_PARAMS= \  
MYSQL_HOST=mysql \  
MYSQL_USER=root  
  
# Update  
RUN apt-get update && \  
apt-get -y dist-upgrade && \  
apt-get -y autoremove && \  
apt-get clean && \  
apt-get install -y \  
mysql-client \  
bzip2 && \  
mkdir /var/dbdumps  
  
COPY ./loop.sh /loop.sh  
COPY ./backup-all-mysql.sh /backup-all-mysql.sh  
COPY ./backup-all-mysql.conf /etc/backup-all-mysql.conf  
  
RUN chmod 0755 /backup-all-mysql.sh && \  
chmod 0755 /loop.sh  
  
VOLUME /var/dbdumps  
ENTRYPOINT ["/loop.sh"]  


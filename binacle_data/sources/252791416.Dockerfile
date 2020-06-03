FROM ubuntu:trusty  
MAINTAINER Daan Sieben  
  
RUN apt-get update && \  
apt-get -y autoremove && \  
apt-get clean && \  
apt-get install -y \  
davfs2 rsync && \  
rm -rf /var/lib/apt/lists/*  
  
RUN mkdir /mnt/webdav/  
RUN mkdir /mnt/backup/  
  
ENV RSYNC_PARAMS "-rP --delete --no-whole-file --inplace"  
COPY entrypoint.sh /  
RUN chmod +x entrypoint.sh  
ENTRYPOINT /entrypoint.sh  


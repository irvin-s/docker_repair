FROM ubuntu:14.04  
RUN apt-get update && \  
apt-get install -y python3-pip libssl-dev libacl1-dev libfuse-dev sshfs && \  
apt-get clean  
  
RUN pip3 install attic  
  
ADD run.sh /bin/run.sh  
ADD backup.py /bin/backup.py  
RUN chmod 755 /bin/*  
  
RUN mkdir /mnt/backup && mkdir /root/.ssh  
  
ENV BACKUP_NAME main.attic  
ENV BACKUP_ROOT /b/  
  
USER root  
  
CMD ["run.sh"]  


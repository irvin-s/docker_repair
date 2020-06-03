FROM ubuntu:xenial  
MAINTAINER ViViDboarder <vividboarder@gmail.com>  
  
RUN apt-get update \  
&& apt-get install -y software-properties-common python-software-properties \  
&& add-apt-repository ppa:duplicity-team/ppa \  
&& apt-get update \  
&& apt-get install -y duplicity python-setuptools ncftp \  
python-swiftclient python-pip python-pexpect openssh-client \  
&& pip install boto \  
&& apt-get autoremove -y python-pip \  
&& apt-get clean \  
&& rm -rf /var/apt/lists/*  
  
VOLUME "/root/.cache/duplicity"  
VOLUME "/backups"  
  
ENV BACKUP_DEST="file:///backups"  
ENV BACKUP_NAME="backup"  
ENV PATH_TO_BACKUP="/data"  
ENV PASSPHRASE="Correct.Horse.Battery.Staple"  
# Cron schedules  
ENV CRON_SCHEDULE=""  
ENV FULL_CRON_SCHEDULE=""  
ENV VERIFY_CRON_SCHEDULE=""  
ADD backup.sh /  
ADD entrypoint.sh /  
ADD restore.sh /  
ADD verify.sh /  
  
ENTRYPOINT [ "/entrypoint.sh" ]  


FROM alpine:latest  
  
MAINTAINER Bjoern Heneka <bheneka@codebee.de>  
  
RUN apk add --no-cache \  
git \  
openssh \  
apk-cron \  
gettext  
  
RUN mkdir -p /etc/periodic/jenkins && \  
mkdir -p /var/jenkins_home  
  
ADD ./crons/backup_cron /etc/periodic/jenkins/backup_cron  
ADD ./templates /templates  
COPY init.sh /root/init.sh  
  
VOLUME /var/jenkins_home  
  
ENV SCHEDULE "*/10 * * * *"  
ENV GIT_USER_EMAIL "john.doe@example.com"  
ENV GIT_USER_NAME "John Doe"  
RUN chmod +x /etc/periodic/jenkins/backup_cron \  
&& chown -R 1000:1000 /var/jenkins_home \  
&& git config --global credential.helper store \  
&& chmod +x /root/init.sh  
  
CMD [ "/bin/sh", "/root/init.sh" ]


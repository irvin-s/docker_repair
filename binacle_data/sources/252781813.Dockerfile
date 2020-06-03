FROM ubuntu:latest  
LABEL org.freenas.autostart="true" \  
org.freenas.interactive="false" \  
org.freenas.version="Latest" \  
org.freenas.upgradeable="true"  
  
RUN apt-get update \  
&& apt-get dist-upgrade -y \  
&& apt-get install -y cron rsyslog  
  
RUN touch /var/log/cron.log  
  
CMD rsyslogd && cron && tail -F /var/log/syslog /var/log/cron.log  


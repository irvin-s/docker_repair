FROM ubuntu:14.04  
MAINTAINER bowwow@gmail.com  
  
RUN apt-get update && apt-get -y install cron nodejs nodejs-legacy  
RUN apt-get -y install npm curl nano  
RUN npm install elasticdump -g  
  
ADD sync.sh /usr/bin/sync.sh  
RUN chmod +x /usr/bin/sync.sh  
  
ADD crontab /etc/cron.d/els-cron  
RUN chmod 0644 /etc/cron.d/els-cron  
RUN touch /var/log/cron.log  
ENTRYPOINT cron && tail -F /var/log/cron.log  


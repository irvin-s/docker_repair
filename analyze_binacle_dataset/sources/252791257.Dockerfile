FROM dockerbase/cron  
  
MAINTAINER Bill Maxwell <bill@rancher.com>  
  
RUN apt-get update && apt-get install -y curl python  
RUN curl -sSL https://get.docker.com | sh  
  
ADD docker_volume_cleanup.py /usr/local/bin/docker_volume_cleanup.py  
ADD crontabs/root /var/spool/cron/crontabs/root  
RUN chmod 600 /var/spool/cron/crontabs/root  
  
RUN touch /var/log/docker_volume_cleanup.log  
ADD logrotate.d/docker_cleanup /etc/logrotate.d/docker_cleanup  
  
CMD cron -L 15 && tail -F /var/log/docker_volume_cleanup.log  


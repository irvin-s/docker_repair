FROM aooj/base  
MAINTAINER AooJ <aooj@n13.cz>  
  
ENV REMOTE_HOST aoj@h.n13.cz  
ENV REMOTE_DIR docker/storage  
ENV LOCAL_DIR /data  
  
RUN apt-get update && apt-get upgrade -y && apt-get install -y sshfs autossh  
  
RUN echo " ServerAliveInterval 5" >> /etc/ssh/ssh_config  
RUN echo " ServerAliveCountMax 5" >> /etc/ssh/ssh_config  
  
ADD files/start.sh /opt/start.sh  
  
VOLUME /data  
  
  
# prepare hosts  
# gpasswd -a username fuse  
# chmod g+rw /dev/fuse  
# chgrp fuse /dev/fuse  


# Apache Storm for Ubuntu 14.04  
#  
# GitHub - http://github.com/dalekurt/docker-storm-nimbus  
# Docker Hub - http://hub.docker.com/u/dalekurt/storm-nimbus  
# Twitter - http://www.twitter.com/dalekurt  
FROM dalekurt/storm  
  
MAINTAINER Dale-Kurt Murray "dalekurt.murray@gmail.com"  
RUN /usr/bin/config-supervisord.sh nimbus  
RUN /usr/bin/config-supervisord.sh drpc  
  
EXPOSE 6627  
EXPOSE 3772  
EXPOSE 3773  
ADD scripts/start-supervisor.sh /usr/bin/start-supervisor.sh  
  
CMD /usr/bin/start-supervisor.sh  


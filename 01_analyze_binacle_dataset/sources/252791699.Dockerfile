# Apache Storm UI for Ubuntu 14.04  
#  
# GitHub - http://github.com/dalekurt/docker-storm-ui  
# Docker Hub - http://hub.docker.com/u/dalekurt/storm-ui  
# Twitter - http://www.twitter.com/dalekurt  
FROM dalekurt/storm  
  
MAINTAINER Dale-Kurt Murray "dalekurt.murray@gmail.com"  
RUN /usr/bin/config-supervisord.sh ui  
  
EXPOSE 8080  
CMD /usr/bin/start-supervisor.sh  


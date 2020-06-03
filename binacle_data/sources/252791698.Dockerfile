# Apache Storm for Ubuntu 14.04  
#  
# GitHub - http://github.com/dalekurt/docker-storm-supervisor  
# Docker Hub - http://hub.docker.com/u/dalekurt/storm-supervisor  
# Twitter - http://www.twitter.com/dalekurt  
FROM dalekurt/storm  
MAINTAINER Dale-Kurt Murray "dalekurt.murray@gmail.com"  
EXPOSE 6700  
EXPOSE 6701  
EXPOSE 6702  
EXPOSE 6703  
EXPOSE 8000  
RUN /usr/bin/config-supervisord.sh supervisor  
RUN /usr/bin/config-supervisord.sh logviewer  
CMD /usr/bin/start-supervisor.sh  


# Apache Storm for Ubuntu 14.04  
#  
# GitHub - http://github.com/dalekurt/docker-storm-nimbus  
# Docker Hub - http://hub.docker.com/u/dalekurt/storm-nimbus  
# Twitter - http://www.twitter.com/dalekurt  
FROM aviata/storm-2  
MAINTAINER jmarsh.ext@aviatainc.com "jmarsh.ext@aviatainc.com"  
RUN /usr/bin/config-supervisord.sh nimbus  
RUN /usr/bin/config-supervisord.sh drpc  
  
EXPOSE 6627  
EXPOSE 3772  
EXPOSE 3773  
COPY scripts/start-supervisor.sh /usr/bin/start-supervisor.sh  
COPY resources/storm.yaml /tmp/storm.yaml  
RUN cp /tmp/storm.yaml $STORM_HOME/conf/storm.yaml  
  
CMD /usr/bin/start-supervisor.sh  


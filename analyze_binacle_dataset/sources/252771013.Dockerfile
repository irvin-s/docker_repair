FROM busybox:latest  
MAINTAINER Adrian Haasler García <dev@adrianhaasler.com>  
  
# Declare volume  
VOLUME /data/jira  
  
# Assign proper ownership and permissions  
CMD chown 547:root /data/jira \  
&& chmod 770 /data/jira  


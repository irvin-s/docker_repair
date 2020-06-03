FROM jenkins/jenkins:lts-alpine  
  
MAINTAINER Bjoern Heneka <bheneka@codebee.de>  
  
USER root  
  
ADD init.sh /usr/local/bin/init.sh  
RUN chmod +x /usr/local/bin/init.sh  
  
USER ${user}  
  
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/init.sh"]  

